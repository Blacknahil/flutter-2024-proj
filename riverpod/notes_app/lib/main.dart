import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/screens/dashboard.dart';
import 'package:notes_app/screens/login_screen.dart';
import 'package:notes_app/screens/welcome_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        
          primarySwatch: Colors.yellow
        ),
        home:   Dashboard(),
      ),
    );
  }
}
