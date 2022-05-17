import 'package:app2/home_screen2.dart';
import 'package:app2/home_screen3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDReceived = "";
  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      hintText: "Enter your Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Visibility(
                                visible: otpCodeVisible,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller: otpCodeController,
                                    decoration: InputDecoration(
                                        hintText: "Enter OTP",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (otpCodeVisible) {
                              verifyCode();
                            } else {
                              verifyNumber();
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blueAccent[900]),
                            child: Center(
                              child: (otpCodeVisible == false)
                                  ? Text(
                                      "Verify Number",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : (Text(
                                      "Verify OTP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          " Or",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePageTwo()),
                                  );
                                },
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blueAccent),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      // SizedBox(
                                      // width: 5.0,
                                      // ),
                                      Text(
                                        'Log-in with Google',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void verifyNumber() {
    auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            print("Logged in successfully");
          });
        },
        verificationFailed: (FirebaseException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
          otpCodeVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived,
        smsCode: otpCodeController.text);
    await auth.signInWithCredential(credential).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageThree()),
      );
    });
  }
}
