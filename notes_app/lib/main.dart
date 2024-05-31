import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/presentations/animations/loading_animations.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NOTES",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcomeScreen();
  }

  _navigateToWelcomeScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 23, 40, 55)),
    );

    return const Scaffold(
      body: LoadingAnimation(),
    );
  }
}
