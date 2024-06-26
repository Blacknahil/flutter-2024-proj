import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  final String imageUrl;
  final String signInMethod;
  final VoidCallback onPressed;

  const LogInButton({
    Key? key,
    required this.imageUrl,
    required this.signInMethod,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            leading: Image.asset(
              imageUrl,
              height: 25,
            ),
            title: Text('Log in with $signInMethod',
                style: const TextStyle(fontSize: 16)),
          )),
    );
  }
}
