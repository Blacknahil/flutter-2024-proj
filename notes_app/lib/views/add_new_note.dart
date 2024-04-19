import "package:flutter/material.dart";

class AddNewNotePage extends StatelessWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController note_title;
    TextEditingController note_body;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 112, 112),
        title: const Text("Add New Note",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
