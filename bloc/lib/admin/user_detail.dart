import 'package:flutter/material.dart';
import 'package:notes_app/presentations/screens/profile/profile.dart';
import 'package:notes_app/user/domain/model/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            Text('ID: ${user.id}', style: TextStyle(fontSize: 18)),
            Text('Password: ${user.password}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Notes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: user.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(user.notes[index].title),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
