import 'package:flutter/material.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/sign_up.dart';
import 'package:notes_app/widgets/black_button.dart';
import 'dart:developer' as devtools;

import 'package:notes_app/widgets/login_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool showPassword = false;

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                key: _formKey,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Welcome!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Please enter your details to continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Please enter your email!";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    height: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(
                              () {
                                showPassword = !showPassword;
                              },
                            );
                          },
                          child: showPassword
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Please enter your password!";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  BlackButton(
                    text: "Log in",
                    callback: HomePage(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "OR",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LogInButton(
                    imageUrl: 'assets/images/google.png',
                    signInMethod: "Google",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUpScreen(), // Replace with your sign up page
                        ),
                      );
                      devtools.log("Go to sign up screen clicked");
                    },
                    child: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                                text: "Sign up for free",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))
                          ]),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(), // Replace with your sign up page
                          ),
                        );
                        devtools.log("Go to Home page screen clicked");
                      },
                      child: RichText(
                        text: const TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "Don't Want to sign up? Continue to use"),
                              TextSpan(
                                  text: " Your Notes App.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 73, 147, 208)))
                            ]),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
