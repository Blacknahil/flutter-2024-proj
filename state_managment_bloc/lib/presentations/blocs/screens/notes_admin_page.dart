import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/constants/colors.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/presentations/blocs/notes_admin_bloc.dart';
import 'package:notes_app/presentations/widgets/alert_dialog.dart';

class NotesAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesAdminBloc(NotesRepository()),
      child: NotesAdminView(),
    );
  }
}

class NotesAdminView extends StatefulWidget {
  @override
  _NotesAdminViewState createState() => _NotesAdminViewState();
}

class _NotesAdminViewState extends State<NotesAdminView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotesAdminBloc>(context).add(LoadNotesAdmin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Admin Page')),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<NotesAdminBloc, NotesAdminState>(
          builder: (context, state) {
            if (state is NotesAdminLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NotesAdminLoaded) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  return Card(
                    child: Container(
                      height: 100,
                      child: ListTile(
                        title: Center(child: Text(note.title)),
                        trailing: Wrap(
                          spacing: 14,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                // Implement Edit functionality
                                // Example:
                                // _showEditDialog(index);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogWidget(
                                      headingText: 'Edit Note',
                                      contentText: 'Edit note content here.',
                                      confirmFunction: () {
                                        // Implement edit logic here.
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
                            ),
                            Text('Edit'),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
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
                                        BlocProvider.of<NotesAdminBloc>(context)
                                            .add(
                                          DeleteAdminNote(note: note),
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
                            ),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is NotesAdminError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
