import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools;

import '../../app_router.dart';
import '../../application/user/bloc/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String sampleName = "sampleName";
  String sampleEmail = 'sample@gmail.com';

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
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: Colors.green,
            ),
          );
          BlocProvider.of<UserProfileBloc>(context).add(ClearMessages());
          Future.delayed(const Duration(seconds: 1), () {
            router.go('/home');
          });

          // router.go('/home');
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isProfileFetched) {
          sampleName = state.name;
          sampleEmail = state.email;

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // Clear messages and navigate back
                  BlocProvider.of<UserProfileBloc>(context)
                      .add(ClearMessages());
                  router.go('/home');
                },
              ),
              backgroundColor: const Color.fromARGB(255, 98, 95, 87),
              title: const Text('Your Profile'),
            ),
            body: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40.0,
                        backgroundImage: AssetImage(
                            'assets/images/avator.jpeg'), // Replace with your avatar image
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sampleName,
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            sampleEmail,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 20.0), // Add some space between the fields
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.8, // 80% of the screen width
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            router.go('/edit_name');
                          },
                          child: const Text(
                            "Change Username",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextButton(
                          style: TextButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                          ),
                          onPressed: () {
                            router.go('/edit_password');
                          },
                          child: const Text(
                            "Change Password",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextButton.icon(
                            onPressed: () {
                              context.read<UserProfileBloc>().add(Logout());
                            },
                            icon: const Icon(Icons.logout_rounded,
                                color: Colors.red),
                            label: const Text(
                              "Logout",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                          child: TextButton.icon(
                            onPressed: () {
                              context
                                  .read<UserProfileBloc>()
                                  .add(DeleteAccount());
                            },
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.red),
                            label: const Text(
                              "Delete Account",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
