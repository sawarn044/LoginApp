import 'package:app2/home_screen3.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class HomePageTwo extends StatefulWidget {
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  State<HomePageTwo> createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");
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
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      hintText: "Enter your email-id",
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
                                    controller: otpController,
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
                              verifyOTP();
                            } else {
                              sendOTP();
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
                                      "Verify Email",
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

  void sendOTP() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5);
    if (result) {
      otpCodeVisible = true;
      setState(() {});
    }
  }

  void verifyOTP() {
    var res = emailAuth.validateOtp(
        recipientMail: emailController.value.text,
        userOtp: otpController.value.text);
    if (res) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageThree()),
      );
    }
  }
}
