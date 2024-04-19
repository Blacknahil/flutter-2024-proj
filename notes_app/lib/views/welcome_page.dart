import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

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
              image: AssetImage("assets/Welcome.png"),
              width: 300,
              height: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Capture Your Moments Pen Your Journey.",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("continue")),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Sign up")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
