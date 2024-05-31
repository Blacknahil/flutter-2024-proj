import 'package:flutter/material.dart';
import 'package:notes_app/presentations/screens/profile/change_name.dart';
import 'package:notes_app/presentations/screens/profile/change_password.dart';
import 'dart:developer' as devtools;

class ProfilePage extends StatefulWidget {
  final String name = "nahom";
  final String email = 'nahom@gmail.com';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.0), // Add some space between the fields
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(
                  'assets/images/avator.jpeg'), // Replace with your avatar image
            ),
            SizedBox(height: 10.0),
            Text(
              widget.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.email,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            SizedBox(height: 20.0), // Add some space between the fields
            Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of the screen width
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => edit_username(),
                          ),
                        );
                        // Navigator.pushNamed(context, )
                        // Add your change username logic here
                      },
                      child: Text(
                        "Change Username",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => edit_password(),
                          ),
                        );
                        // Add your change username logic here
                      },
                      child: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextButton.icon(
                        onPressed: () => print('logout'),
                        icon: Icon(Icons.logout_rounded, color: Colors.red),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: TextButton.icon(
                        onPressed: () {
                          devtools.log("Delete Account Button clicked");
                          print('Delete Account');
                        },
                        icon: Icon(Icons.delete_forever, color: Colors.red),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
