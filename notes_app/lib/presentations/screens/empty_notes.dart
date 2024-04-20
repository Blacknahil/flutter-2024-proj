import 'package:flutter/material.dart';

Widget emptyNotes() {
  return const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          height: 200,
          width: 200,
          image: AssetImage('assets/images/no_notes1.png'),
        ),
        Text(
          "Create your first note!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
