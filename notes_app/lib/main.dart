import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/presentations/screens/add_new_note.dart';
import 'package:notes_app/presentations/screens/edit_notes.dart';
import 'package:notes_app/presentations/screens/home_page.dart';
import 'package:notes_app/presentations/screens/log_in.dart';
import 'package:notes_app/presentations/screens/sign_up.dart';
import 'package:notes_app/presentations/screens/view_specific_note_page.dart';
import 'package:notes_app/presentations/screens/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 23, 40, 55)),
    );

    return MaterialApp(
      title: "NOTES",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
