import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_router.dart';
import '../../application/user/bloc/user_bloc.dart';
import '../widgets/progress.dart';

class EditPassword extends StatefulWidget {
  EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  Column buildDisplayOldPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Old Password",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: oldPasswordController,
          obscureText: true, // for password input
          decoration: const InputDecoration(
            hintText: "Enter your old password",
          ),
        )
      ],
    );
  }

  Column buildDisplayNewPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "New Password",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: newPasswordController,
          obscureText: true, // for password input
          decoration: const InputDecoration(
            hintText: "Enter your new password",
          ),
        )
      ],
    );
  }

  Column buildDisplayConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Confirm New Password",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: confirmPasswordController,
          obscureText: true, // for password input
          decoration: const InputDecoration(
            hintText: "Confirm your new password",
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!context.read<UserProfileBloc>().state.isProfileFetched) {
        router.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Clear messages and navigate back
            BlocProvider.of<UserProfileBloc>(context).add(ClearMessages());
            router.go('/profile');
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       devtools.log("Save Password Changes");
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.done,
        //       size: 30.0,
        //       color: Colors.green,
        //     ),
        //   ),
        // ],
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
          } else if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
              ),
            );

            router.go('/profile');
            BlocProvider.of<UserProfileBloc>(context).add(ClearMessages());
            // Navigate to profile screen after successful password chang
          }
        },
        builder: (context, state) {
          return !state.isProfileFetched
              ? circularProgress()
              : ListView(
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
                              buildDisplayOldPasswordField(),
                              buildDisplayNewPasswordField(),
                              buildDisplayConfirmPasswordField(),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Invoke change password event
                            BlocProvider.of<UserProfileBloc>(context).add(
                              ChangePassword(
                                oldPasswordController.text,
                                newPasswordController.text,
                                confirmPasswordController.text,
                              ),
                            );
                          },
                          child: Text(
                            "Save changes",
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
        },
      ),
    );
  }
}
