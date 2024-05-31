import 'dart:developer' as devtools;

import "package:flutter/material.dart";
import 'package:notes_app/presentations/widgets/progress.dart';

class edit_password extends StatefulWidget {
  @override
  _edit_passwordState createState() => _edit_passwordState();
}

class _edit_passwordState extends State<edit_password> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  // User user;

  @override
  void initState() {
    super.initState();
  }

  Column buildDisplayOldPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "old Password",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: oldPasswordController,
          decoration: InputDecoration(
            hintText: "User Name",
          ),
        )
      ],
    );
  }

  Column buildDisplayNewPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Enter New Password",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: newPasswordController,
          decoration: InputDecoration(
            hintText: "new password",
          ),
        )
      ],
    );
  }

  Column buildDisplayConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Re Enter new Password",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            hintText: "confrim password",
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Change User Name",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              devtools.log("Save Profile Data");
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
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
                          print('update profile data');
                          devtools.log('update name');
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
                ),
              ],
            ),
    );
  }
}
