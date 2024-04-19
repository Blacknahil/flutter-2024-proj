import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/views/add_new_note.dart';
import 'package:notes_app/views/edit_notes.dart';
import 'package:notes_app/views/home_page.dart';
import 'package:notes_app/views/sign_up.dart';
import 'package:notes_app/views/view_notes_page.dart';

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
        "/": (context) => const HomePage(),
        "/signup": (context) => const SignUpApp(),
        "/editnote": (context) => const ViewNotesPage(),
        "/addNewNote": (context) => const AddNewNotePage(),
      },
    );
  }
}
