import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_router.dart';
import '../../application/user/bloc/user_bloc.dart';
import 'user_detail.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<UserProfileBloc>().add(Logout());
              router.go('/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(user: user),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state.errorMessage != null &&
              state.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Default error message')),
            );
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import '../../domain/user/user.dart';

// class AdminDashboard extends StatefulWidget {
//   @override
//   _AdminDashboardState createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   User? selectedUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Dashboard'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               color: Colors.grey[200],
//               child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(users[index].name),
//                     onTap: () {
//                       setState(() {
//                         selectedUser = users[index];
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/background1.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: selectedUser == null
//                   ? Center(child: Text('Select a user to view their notes'))
//                   : Column(
//                       children: [
//                         AppBar(
//                           title: Text('${selectedUser!.name}\'s Notes'),
//                           backgroundColor: Colors.yellow,
//                         ),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: selectedUser!.notes.length,
//                             itemBuilder: (context, index) {
//                               return Card(
//                                 child: ListTile(
//                                   title: Center(
//                                       child: Text(selectedUser!.notes[index])),
//                                   trailing: Wrap(
//                                     spacing: 14,
//                                     children: <Widget>[
//                                       IconButton(
//                                         icon: Icon(Icons.edit,
//                                             color: Colors.blue),
//                                         onPressed: () {},
//                                       ),
//                                       Text('Edit'),
//                                       IconButton(
//                                         icon: Icon(Icons.delete,
//                                             color: Colors.red),
//                                         onPressed: () {},
//                                       ),
//                                       Text('Delete'),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
