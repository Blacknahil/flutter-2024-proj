import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools;

import '../../app_router.dart';
import '../../application/folder/bloc/folder_bloc.dart';
import '../../application/user/bloc/user_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, userstate) {
                    devtools.log("Drawer state: ${userstate.isProfileFetched}");
                    devtools.log(userstate.name);
                    if (userstate.isProfileFetched) {
                      return DrawerHeader(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 128, 161, 189),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.person, size: 18.0),
                                onPressed: () {
                                  devtools.log("Edit profile has been clicked");
                                  router.go('/profile');
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userstate.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                            Text(
                              userstate.email,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                            Text(
                              'You have ${userstate.folderIds.length} Folders',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Future.delayed(const Duration(seconds: 2), () {
                        router.go('/login');
                      });

                      return const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 128, 161, 189),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
                BlocListener<FoldersBloc, FolderState>(
                  listener: (context, state) {
                    if (state is FolderLoaded && state.successMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.successMessage!)),
                      );
                    } else if (state is FolderError && state.message != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  child: BlocBuilder<FoldersBloc, FolderState>(
                    builder: (context, folderState) {
                      if (folderState is FolderLoaded) {
                        return Column(
                          children: folderState.folders.map((folder) {
                            return ListTile(
                              title: Text(folder.title),
                              onTap: () {
                                final userProfileState =
                                    context.read<UserProfileBloc>().state;
                                if (userProfileState.isProfileFetched) {
                                  final token = userProfileState.token;
                                  context.read<FoldersBloc>().add(
                                      ChangeCurrentFolder(folder.id, token));
                                }

                                // context.read<NotesBloc>().add(FetchFolderNotes(folder.id));
                                Navigator.pop(context); // Close the drawer
                              },
                            );
                          }).toList(),
                        );
                      } else if (folderState is FolderLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (folderState is FolderError) {
                        return Center(child: Text(folderState.message));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 23.0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 128, 184, 230),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextButton(
                onPressed: () {
                  final userProfileState =
                      context.read<UserProfileBloc>().state;
                  if (userProfileState.isProfileFetched) {
                    final userId = userProfileState.userId;
                    final token = userProfileState.token;
                    devtools.log("Add folder name pop up");
                    // Show dialog to enter folder name
                    showDialog(
                      context: context,
                      builder: (context) {
                        String folderName = '';
                        return AlertDialog(
                          title: const Text('Add Folder'),
                          content: TextField(
                            onChanged: (value) {
                              folderName = value;
                            },
                            decoration:
                                const InputDecoration(hintText: "Folder Name"),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<FoldersBloc>().add(
                                    CreateFolder(folderName, userId, token));
                                Navigator.pop(context);
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 7),
                    Text("Add a folder"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
