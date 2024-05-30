// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:notes_app/admin/presentation/screen/home_screen.dart';
// import 'package:notes_app/admin/presentation/screen/user_detail_screen.dart';
// import 'package:notes_app/admin/presentation/screen/user_list_screen.dart';

// class AppRouter {
//   static final router = GoRouter(
//     initialLocation: '/home',
//     errorPageBuilder: (context, state) => MaterialPage(child: Text('Error')),
//     pageBuilder: (context, state, _) => _buildPage(state),
//     routes: [],
//   );

//   static GoRouterFunction _buildPage(RouteState state) {
//     final location = state.location;
//     final params = state.params;

//     if (location == '/home') {
//       return MaterialPage(child: AdminHomeScreen());
//     }

//     if (location == '/user-list') {
//       return MaterialPage(child: UserListScreen());
//     }

//     if (location == '/user-detail') {
//       final userId = params['userId'];
//       return MaterialPage(child: UserDetailScreen(userId: userId!));
//     }

//     // Handle unknown routes
//     return MaterialPage(
//         child: Scaffold(body: Center(child: Text('Not Found'))));
//   }
// }



// // class AppRouter {
// //   static final router = GoRouter(
// //     initialLocation: '/home',
// //     errorPageBuilder: (context, state) => MaterialPage(child: Text('Error')),
// //     pageBuilder: (context, state, _) => _buildPage(state),
// //     routes: [],
// //   );

// //   static GoRouterFunction _buildPage(RouteState state) {
// //     final location = state.location;
// //     final params = state.params;

// //     if (location == '/home') {
// //       return MaterialPage(child: HomeScreen());
// //     }

// //     if (location == '/user-list') {
// //       return MaterialPage(child: UserListScreen());
// //     }

// //     if (location == '/user-detail') {
// //       final userId = params['userId'];
// //       return MaterialPage(child: UserDetailScreen(userId: userId!));
// //     }

// //     // Handle unknown routes
// //     return MaterialPage(
// //         child: Scaffold(body: Center(child: Text('Not Found'))));
// //   }
// // }





