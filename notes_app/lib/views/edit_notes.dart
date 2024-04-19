import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'dart:developer' as devtools;

import 'package:notes_app/constants/colors.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController note_title_controller;
  late TextEditingController note_body_controller;

  @override
  void initState() {
    super.initState();

    note_title_controller =
        TextEditingController(text: "This is title of the note");
    note_body_controller = TextEditingController(
        text:
            " This is the body of the text to be editied.some bulha some blahaha asjbjhs ilskjbdjls");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit Note",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              TextField(
                controller: note_title_controller,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                cursorColor: Colors.black,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  // hintText: note_title,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              TextField(
                controller: note_body_controller,
                style: const TextStyle(
                  fontSize: 13,
                ),
                cursorColor: Colors.black,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 13),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // update note and update the time stamp
          devtools.log("edit note and save the note button clicked");
        },
        label: const Text(
          "Save",
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        icon: const Icon(
          Icons.save,
        ),
        backgroundColor: AppColor.buttonColor,
      ),
    );
  }
}
