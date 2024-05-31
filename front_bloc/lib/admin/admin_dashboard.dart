import 'package:flutter/material.dart';
import 'package:notes_app/admin/user_detail.dart';
import 'package:notes_app/user/domain/model/user.dart';

class AdminDashboard extends StatelessWidget {
  final List<User> users;

  AdminDashboard({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailsPage(user: users[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
