import 'dart:ui';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/presentations/screens/add_new_note.dart';
import 'package:notes_app/presentations/screens/edit_notes.dart';
import 'package:notes_app/presentations/screens/empty_notes.dart';
import 'package:notes_app/presentations/screens/navigation.dart';
import 'package:notes_app/presentations/screens/view_specific_note_page.dart';
import 'package:notes_app/presentations/screens/welcome_page.dart';
import 'package:notes_app/presentations/widgets/alert_dialog.dart';
import "dart:developer" as devtools;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> _isFavourite = List.generate(10, (index) => false);
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: "Search a note",
                ),
              )
            : const Text(
                "Notes App",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(
                    () {
                      _isSearching = false;
                      _searchController.clear();
                    },
                  );
                },
              )
            : Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    devtools.log("Navigation button cicked");
                  },
                );
              }),
        backgroundColor: const Color.fromARGB(255, 216, 195, 195),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: _isSearching
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              ]
            : [
                IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const SearchScreen(),
                    //   ),
                    // );
                    setState(() {
                      _isSearching = true;
                    });
                    devtools.log("Search button clicked");
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
                                  Navigator.pop(context);
                                },
                                child: const Text("Confirm"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
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
      drawer: AppDrawer(),
      body: viewNotes(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // To do fix the navigation according to the requirement here!!
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
                        Navigator.pop(context);
                      },
                      declineFunction: () {
                        //Edit the navigation as per the requirement.
                        Navigator.pop(context);
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
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            devtools.log("Add to favourites");
                            setState(
                              () {
                                _isFavourite[index] = !_isFavourite[index];
                              },
                            );
                          },
                          child: Icon(
                              _isFavourite[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavourite[index]
                                  ? const Color.fromARGB(255, 227, 154, 154)
                                  : null),
                        ),
                        SizedBox(width: 4),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogWidget(
                                  headingText: 'Delete Note',
                                  contentText:
                                      'Are you sure you want to delete this Note?',
                                  confirmFunction: () {
                                    // Add your delete logic here
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  declineFunction: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                );
                              },
                            );
                          },
                        )
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
