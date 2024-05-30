import 'dart:developer' as devtools;

import 'package:bloc_2/app_router.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/user/bloc/user_bloc.dart';
import '../widgets/progress.dart';

class edit_username extends StatefulWidget {
  @override
  _edit_usernameState createState() => _edit_usernameState();
}

class _edit_usernameState extends State<edit_username> {
  TextEditingController nameController = TextEditingController();
  // TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  // User user;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.read<UserProfileBloc>().state.isProfileFetched) {
        router.go('/login');
      }
    });
  }

  Column buildDisplayNameField(String pastUsername) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            pastUsername,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "User Name",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              BlocProvider.of<UserProfileBloc>(context).add(ClearMessages());

              router.go('/profile');
            },
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Change Username",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: BlocConsumer<UserProfileBloc, UserProfileState>(
            listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
            devtools.log("update username failed");
          } else if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
              ),
            );
            devtools.log("update username success");
            // Clear the messages and navigate back
            BlocProvider.of<UserProfileBloc>(context).add(ClearMessages());
            router.go('/profile');
          }
        }, builder: (context, state) {
          if (!state.isProfileFetched) {
            return circularProgress();
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: CircleAvatar(
                        radius: 50.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          buildDisplayNameField(state.name),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        devtools.log('update username clicked');
                        BlocProvider.of<UserProfileBloc>(context).add(
                          UpdateUsername(nameController.text),
                        );
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        }));
  }
}
