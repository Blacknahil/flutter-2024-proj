import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/user/user.dart';
import '../../application/bloc/user_bloc.dart';
import '../../application/bloc/user_state.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final User user =
                state.users.firstWhere((User? user) => user?.id == userId);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.name}'),
                Text('Email: ${user.email}'),
                Text('Number of Notes: ${user.folders.length}'),
                // Display user notes
              ],
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
