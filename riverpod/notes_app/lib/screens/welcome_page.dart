import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "dart:developer" as devtools;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 207, 28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Image(
              image: AssetImage("assets/images/Welcome.png"),
              width: 300,
              height: 300,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 8.0,
              left: 10,
              right: 10,
            ),
            child: Text(
              "Capture Your Moments. \n Pen Your Journey.",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.go('/login');
              devtools.log(
                  " INk well : Arrow button clicked continue to the next screen");
            },
            child: const Padding(
              padding: EdgeInsets.only(
                top: 5,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Color.fromARGB(255, 44, 62, 77),
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
