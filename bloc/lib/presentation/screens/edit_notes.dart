import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools;

import '../../app_router.dart';
import '../../application/note/bloc/note_bloc.dart';
import '../../application/user/bloc/user_bloc.dart';
import '../constants/colors.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController noteTitleController;
  late TextEditingController noteBodyController;

  @override
  void initState() {
    super.initState();
    final currentNote =
        (context.read<NoteBloc>().state as NotesLoaded).currentNote;
    noteTitleController = TextEditingController(text: currentNote?.title ?? '');
    noteBodyController =
        TextEditingController(text: currentNote?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              router.go("/home");
            },
          );
        }),
        backgroundColor: Color.fromARGB(255, 134, 120, 120),
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
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              TextField(
                controller: noteTitleController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              TextField(
                controller: noteBodyController,
                style: const TextStyle(
                  fontSize: 13,
                ),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 13),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final noteTitle = noteTitleController.text;
          final noteBody = noteBodyController.text;

          if (noteTitle.isEmpty || noteBody.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Title and body cannot be empty"),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          final noteBloc = context.read<NoteBloc>();
          final currentNote = (noteBloc.state as NotesLoaded).currentNote;

          if (currentNote != null) {
            noteBloc.add(UpdateNote(
                noteTitle,
                noteBody,
                currentNote.id,
                context.read<UserProfileBloc>().state.userId,
                context.read<UserProfileBloc>().state.token));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Successfully update note"),
                backgroundColor: Colors.greenAccent,
              ),
            );
            router.go('/viewSpecificNote');
          }
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
