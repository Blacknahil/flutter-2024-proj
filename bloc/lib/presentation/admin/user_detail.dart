import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/user/bloc/user_bloc.dart';
import '../../../domain/user/user.dart';
import '../../app_router.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? "An error occurred")),
            );
          } else if (state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? "Success")),
            );
            context.read<UserProfileBloc>().add(ClearMessages());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${user.name}"),
                Text("Email: ${user.email}"),
                Text("User ID: ${user.id}"),
                Text("Folders: ${user.folders.length}"),
                Text("Banned: ${user.banned}"),
                Text("Role: ${user.role}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final token = context.read<UserProfileBloc>().state.token;

                    if (user.banned) {
                      context
                          .read<UserProfileBloc>()
                          .add(UnBanUser(user.id, token));
                    } else {
                      context
                          .read<UserProfileBloc>()
                          .add(BanUser(user.id, token));
                    }
                    Navigator.pop(context);
                  },
                  child: Text(user.banned ? "Unban User" : "Ban User"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      final token = context.read<UserProfileBloc>().state.token;
                      context
                          .read<UserProfileBloc>()
                          .add(DeleteUserAdmin(user.id, token));
                      Navigator.pop(context);
                    },
                    child: const Text('Delete User')),
              ],
            ),
          ),
        ));
  }
}
