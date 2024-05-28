import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:notes_app/constants/colors.dart";
import "dart:developer" as devtools;

class AddNewNotePage extends StatelessWidget {
  const AddNewNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController note_title;
    TextEditingController note_body;

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
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
              ),
              child: const Column(
                children: [
                  TextField(
                    // controller: note_title,
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
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    // controller: note_body,
                    decoration: InputDecoration(
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
            //To do fix the navigation here.
            Navigator.pop(context);
            devtools.log("Save new note clicked , Input validation ");
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
