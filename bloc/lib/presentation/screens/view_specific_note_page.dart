import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_router.dart';
import '../../application/note/bloc/note_bloc.dart';

class ViewSpecificNotePage extends StatelessWidget {
  const ViewSpecificNotePage({Key? key}) : super(key: key);

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
        title: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NotesLoaded && state.currentNote != null) {
              return Text(
                state.currentNote!.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            child: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NotesLoaded && state.currentNote != null) {
                  return Text(
                    state.currentNote!.content,
                    style: const TextStyle(fontSize: 15),
                  );
                } else {
                  return const Text("Loading...");
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NotesLoaded && state.currentNote != null) {
            return FloatingActionButton(
              onPressed: () {
                router.go('/editNoteScreen');
              },
              child: const Icon(Icons.edit),
            );
          } else {
            return const SizedBox
                .shrink(); // Return an empty widget if note is not loaded
          }
        },
      ),
    );
  }
}
