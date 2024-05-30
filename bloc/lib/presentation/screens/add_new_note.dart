import "package:bloc_2/application/folder/bloc/folder_bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get/get.dart";
import "dart:developer" as devtools;

import "../../app_router.dart";
import "../../application/note/bloc/note_bloc.dart";
import "../../application/user/bloc/user_bloc.dart";
import "../constants/colors.dart";

class AddNewNotePage extends StatelessWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteTitleController = TextEditingController();
    final TextEditingController _noteBodyController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 189, 112, 112),
          title: const Text(
            "Add New Note",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 176, 96, 96),
          ),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              router.go('/home');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _noteTitleController,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.hintColor,
                      ),
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    cursorColor: Colors.black,
                    maxLines: null,
                  ),
                  TextField(
                    controller: _noteBodyController,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    // controller: note_body,
                    decoration: const InputDecoration(
                      hintText: "Type Note here....",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColor.hintColor,
                      ),
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final noteTitle = _noteTitleController.text;
            final noteBody = _noteBodyController.text;

            if (noteTitle.isEmpty || noteBody.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Title and body cannot be empty"),
                ),
              );
              return;
            }

            final userProfileState = context.read<UserProfileBloc>().state;
            final folderState = context.read<FoldersBloc>().state;

            if (userProfileState.isProfileFetched) {
              if (folderState is FolderLoaded &&
                  folderState.currentFolder != null) {
                final folderId = folderState.currentFolder!.id;
                context.read<NoteBloc>().add(CreateNote(noteTitle, noteBody,
                    userProfileState.userId, folderId, userProfileState.token));
                devtools.log(
                    "Save new note clicked, Input validated and note added");
                router.go('/home');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Choose a folder To create a note"),
                  ),
                );
                return;
              }
            }
          },
          label: const Text("Save",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
          icon: const Icon(
            Icons.save,
          ),
          backgroundColor: AppColor.buttonColor,
        ));
  }
}
