import 'package:bloc_2/application/user/bloc/user_bloc.dart';
import 'package:bloc_2/presentation/screens/empty_notes.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import "dart:developer" as devtools;

import '../../app_router.dart';
import '../../application/folder/bloc/folder_bloc.dart';
import '../../application/note/bloc/note_bloc.dart';
import '../constants/colors.dart';
import '../widgets/alert_dialog.dart';
import 'add_new_note.dart';
import 'navigation.dart';
import 'view_specific_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (!context.read<UserProfileBloc>().state.isProfileFetched) {
        router.go('/login');
      } else {
        final userId = context.read<UserProfileBloc>().state.userId;
        final token = context.read<UserProfileBloc>().state.token;
        context.read<FoldersBloc>().add(FetchFolders(userId, token));

        final folderState = context.read<FoldersBloc>().state;
        if (folderState is FolderLoaded) {
          final currentFolder = folderState.currentFolder;
          if (currentFolder == null) {
            context.read<NoteBloc>().add(FetchAllUserNotes(userId, token));
          } else {
            context
                .read<NoteBloc>()
                .add(FetchNotesByFolder(currentFolder.id, token));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //create a multi bloc provider
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<FoldersBloc, FolderState>(
          builder: (context, folderState) {
            String title;
            if (folderState is FolderLoaded) {
              title = folderState.currentFolder?.title ?? "Notes App";
            } else {
              title = "Notes App";
            }
            return Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              devtools.log("Navigation button clicked");
            },
          );
        }),
        backgroundColor: const Color.fromARGB(255, 216, 195, 195),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      drawer: AppDrawer(),
      body: BlocListener<FoldersBloc, FolderState>(
        listener: (context, folderState) {
          if (folderState is FolderLoaded) {
            final userProfileState = context.read<UserProfileBloc>().state;
            final userId = userProfileState.userId;
            final token = userProfileState.token;
            final currentFolder = folderState.currentFolder;
            devtools.log("home page cur folder is $currentFolder");

            if (currentFolder == null) {
              context.read<NoteBloc>().add(FetchAllUserNotes(userId, token));
            } else {
              context
                  .read<NoteBloc>()
                  .add(FetchNotesByFolder(currentFolder.id, token));
            }
          }
        },
        child: BlocListener<NoteBloc, NoteState>(
          listener: (context, noteState) {
            if (noteState is NotesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(noteState.message)),
              );
            } else if (noteState is NotesLoaded) {
              if (noteState.successMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(noteState.successMessage!)),
                );
              }
            }
          },
          child: viewNotes(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          router.go("/addNewNotePage");
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
//view notes

//view notes

//view notes
  Widget viewNotes() {
    return BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
      if (state is NotesLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is NotesLoaded && state.notesArr.isNotEmpty) {
        return Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: state.notesArr.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final token = context.read<UserProfileBloc>().state.token;
                    context.read<NoteBloc>().add(ChangeCurrentNote(
                          state.notesArr[index].id,
                          token,
                        ));
                    router.go("/viewSpecificNote");
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.notesArr[index].title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  state.notesArr[index].content,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColor.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialogWidget(
                                    headingText: 'Delete Note',
                                    contentText:
                                        'Are you sure you want to delete this Note?',
                                    confirmFunction: () {
                                      context.read<NoteBloc>().add(DeleteNote(
                                          state.notesArr[index].id,
                                          context
                                              .read<UserProfileBloc>()
                                              .state
                                              .userId,
                                          context
                                              .read<UserProfileBloc>()
                                              .state
                                              .token));
                                      Navigator.of(context).pop();
                                    },
                                    declineFunction: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return emptyNotes();
      }
    });
  }
}
