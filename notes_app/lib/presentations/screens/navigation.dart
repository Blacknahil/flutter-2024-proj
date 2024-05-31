import 'package:flutter/material.dart';
import 'dart:developer' as devtools;
import 'package:notes_app/presentations/screens/profile/profile.dart';

// class NavigationScreen extends StatefulWidget {
//   const NavigationScreen({super.key});

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Builder(
//         builder: (BuildContext context) {
//           return ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 child: Text('Drawer Header'),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//               ),
//               ListTile(
//                 title: Text('Item 1'),
//                 onTap: () {
//                   // Update the state of the app
//                   // Then close the drawer
//                   // Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Item 2'),
//                 onTap: () {
//                   // Update the state of the app
//                   // Then close the drawer
//                   // Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //width: 300,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true, // This is the key
                  physics:
                      NeverScrollableScrollPhysics(), // to disable scrolling in the ListView
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              radius: 18.0,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.person, size: 18.0),
                                onPressed: () {
                                  devtools.log("Edit profile has been clicked");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'User Name',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Person Email',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'You have 5 Folders',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 128, 161, 189),
                      ),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        // Update the state of the app
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 23.0,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 184, 230),
                  borderRadius: BorderRadius.circular(20.0)),
              child: TextButton(
                onPressed: () {
                  // Add your onPressed code here!
                  devtools.log("Add folder name pop up");
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 7),
                    Text("Add a folder")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
