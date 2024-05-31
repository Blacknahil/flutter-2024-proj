import 'package:flutter/material.dart';
import 'package:notes_app/user/domain/model/user.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  UserTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: onTap,
    );
  }
}
