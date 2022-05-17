import 'package:flutter/material.dart';

class HomePageThree extends StatelessWidget {
  const HomePageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //Scaffold(
        //body:
        Container(
      //width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ]),
      ),
      child: Center(
        child: Text(
          " Sucessfully Logged In",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 20),
        ),
      ),
    );
    //);
  }
}
