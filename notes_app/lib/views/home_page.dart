import 'dart:ui';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/views/add_new_note.dart';
import 'package:notes_app/views/edit_notes.dart';
import 'package:notes_app/views/empty_notes.dart';
import 'package:notes_app/views/view_notes_page.dart';
import 'package:notes_app/widgets/alert_dialog.dart';
import "dart:developer" as devtools;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes App",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 216, 195, 195),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // To do implement the search screen
              // showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          "Are you sure you want to delete all notes?"),
                      content: const Text(
                          "This will delete all notes permanently. You cannot undo this action."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // controller.deleteAllNotes();
                            Get.back();
                          },
                          child: Text("Confirm"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: viewNotes(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewNotePage(),
            ),
          );

          devtools.log("Add new Notes button clicked on home page");
        },
        label: const Text(
          "Add New Note",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
        ),
        backgroundColor: const Color.fromARGB(255, 226, 189, 189),
      ),
    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          shrinkWrap: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                devtools.log("Enter to edit notes screen");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNotesPage(),
                  ),
                );
                //action for taping a notes tab
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      headingText: "Are you sure You want to delete this note?",
                      contentText:
                          "This Action will Delete The Note permanently.",
                      confirmFunction: () {
                        //action to delete the note upon confimration.
                        // Navigation handler
                        Get.back();
                      },
                      declineFunction: () {
                        //Edit the navigation as per the requirement.
                        Get.back();
                      },
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.grayColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "This a Notes Title",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "This is the body of a single text file ",
                                style: TextStyle(
                                    fontSize: 14, color: AppColor.textColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () {
                              devtools.log("Add to favourites");
                            },
                            child: const Icon(
                              Icons.favorite_border,
                            ))
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
