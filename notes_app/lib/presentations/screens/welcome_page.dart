import 'package:flutter/material.dart';
import "dart:developer" as devtools;

import 'package:notes_app/presentations/screens/log_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 207, 28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Image(
              image: AssetImage("assets/images/Welcome.png"),
              width: 300,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 8.0,
              left: 10,
              right: 10,
            ),
            child: Text("Capture Your Moments. \n Pen Your Journey.",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                )),
          ),
          InkWell(
            onTap: () {
              devtools.log(
                  " INk well : Arrow button clicked continue to the next screen");
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       devtools.log("Continue button clicked");
                  //     },
                  //     child: Text("continue")),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20),
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         devtools.log("Sign up button clicked");
                  //       },
                  //       child: Text("Sign up")),
                  //       ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(),
                        ),
                      );
                      devtools.log(
                          "Arrow button clicked continue to the next screen");
                    },
                    icon: Icon(Icons.arrow_forward_rounded,
                        color: Color.fromARGB(255, 44, 62, 77)),
                    iconSize: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
