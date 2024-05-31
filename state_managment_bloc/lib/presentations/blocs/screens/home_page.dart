// lib/presentations/screens/home_page.dart
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentations/blocs/notes_bloc.dart';
import 'package:notes_app/presentations/screens/add_new_note.dart';
import 'package:notes_app/presentations/screens/edit_notes.dart';
import 'package:notes_app/presentations/screens/empty_notes.dart';
import 'package:notes_app/presentations/screens/navigation.dart';
import 'package:notes_app/presentations/screens/view_specific_note_page.dart';
import 'package:notes_app/presentations/screens/welcome_page.dart';
import 'package:notes_app/presentations/widgets/alert_dialog.dart';
import "dart:developer" as devtools;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(NotesRepository()),
      child: Scaffold(
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
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesInitial) {
              BlocProvider.of<NotesBloc>(context).add(LoadNotes());
              return Center(child: CircularProgressIndicator());
            } else if (state is NotesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NotesLoaded) {
              if (state.notes.isEmpty) {
                return const EmptyNotes();
              } else {
                return Scrollbar(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                      left: 10,
                    ),
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
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
                                  headingText:
                                      "Are you sure You want to delete this note?",
                                  contentText:
                                      "This Action will Delete The Note permanently.",
                                  confirmFunction: () {
                                    //action to delete the note upon confimration.
                                    BlocProvider.of<NotesBloc>(context)
                                        .add(DeleteNote(note: note));
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
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            note.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.textColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            note.body,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: AppColor.textColor),
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
                                        BlocProvider.of<NotesBloc>(context)
                                            .add(UpdateNote(
                                          note: note.copyWith(
                                            isFavorite: !note.isFavorite,
                                          ),
                                        ));
                                      },
                                      child: Icon(
                                          note.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: note.isFavorite
                                              ? const Color.fromARGB(
                                                  255, 227, 154, 154)
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
                                                BlocProvider.of<NotesBloc>(
                                                        context)
                                                    .add(
                                                  DeleteNote(note: note),
                                                );
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
            } else if (state is NotesError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return Container();
            }
          },
        ),
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
      ),
    );
  }
}
