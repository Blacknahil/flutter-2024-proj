import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/screens/add_new_note.dart';
import 'package:notes_app/screens/edit_notes.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/log_in.dart';
import 'package:notes_app/screens/search_screen.dart';
import 'package:notes_app/screens/sign_up.dart';
import 'package:notes_app/screens/view_specific_note_page.dart';
import 'package:notes_app/screens/welcome_page.dart';

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
      initialRoute: "/",
      routes: {
        "/homescreen": (context) => const HomePage(),
        "/signup": (context) => const SignUpApp(),
        "/editnote": (context) => const ViewNotesPage(),
        "/addNewNote": (context) => const AddNewNotePage(),
        "/searchscrenn": (context) => const SearchScreen(),
        "/": (context) => const WelcomeScreen(),
        "login": (context) => const LogInScreen(),
      },
    );
  }
}
