import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/providers/notes_provider.dart';
import "dart:developer" as devtools;
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final formKey = GlobalKey<FormState>();
  final notesCtrl = TextEditingController();
  late FocusNode txtFocusNode;
  List<bool> _isFavourite = List.generate(10, (index) => false);
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    txtFocusNode = FocusNode();
  }

  @override
  void dispose() {
    txtFocusNode.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
        body: Consumer(
          builder: (context, ref, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: notesCtrl,
                        focusNode: txtFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter some text";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Save the note
                              ref.read(notesProvider).onSaveNote(notesCtrl.text);

                              // Clear the form and text field
                              formKey.currentState!.reset();
                              notesCtrl.clear();

                              // Unfocus the text field to hide the keyboard
                              FocusScope.of(context).unfocus();

                              // Show a snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Note added"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.amber,
                                ),
                              );
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                      const SizedBox(height: 16), // Add some spacing below the button
                      const NotesListView(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class NotesListView extends ConsumerWidget {
  const NotesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);
    final notesList = notesState.notesList;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(notesList[index].toString()),
            trailing:GestureDetector(
              onTap: () {


                ref.read(notesProvider).onRemoveNotes(index);

                ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Note removed"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
              },
              child: const Icon(Icons.delete, color: Colors.black,),)
            
          ),
        );
      },
    );
  }
}
