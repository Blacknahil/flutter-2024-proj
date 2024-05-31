import 'package:flutter/material.dart';
import 'package:notes_app/admin/admin_dashboard.dart';
import 'package:notes_app/user/domain/model/user.dart';

import '../note/domain/model/note.dart';

//convert the main funcion to a admin home page class
class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AdminDashboard(
      users: [
        User(
          id: '1',
          name: 'John Doe',
          email: 'john.doe@example.com',
          password: 'password123',
          notes: [
            Note(title: 'Note 1', String: null, id: '1', content: 'dskjd')
          ],
        ),
        User(
          id: '2',
          name: 'Jane Smith',
          email: 'jane.smith@example.com',
          password: 'password456',
          notes: [
            Note(title: 'Note 1', String: null, id: '1', content: 'dskjd')
          ],
        ),
        // Add more users as needed
      ],
    ));
  }
}
