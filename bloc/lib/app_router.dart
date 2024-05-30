import 'package:bloc_2/presentation/log_in/login_in_page.dart';
import 'package:bloc_2/presentation/profile/change_name.dart';
import 'package:bloc_2/presentation/profile/change_password.dart';
import 'package:bloc_2/presentation/profile/profile.dart';
import 'package:bloc_2/presentation/screens/add_new_note.dart';
import 'package:bloc_2/presentation/screens/edit_notes.dart';
import 'package:bloc_2/presentation/screens/view_specific_note_page.dart';
import 'package:bloc_2/presentation/screens/welcome_page.dart';
import 'package:bloc_2/presentation/sign_up/sign_up_page.dart';
import 'package:bloc_2/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'presentation/admin/admin_dashboard.dart';
import 'presentation/admin/user_detail.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPageProvider(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => SignUpAppProvider(),
    ),
    GoRoute(
      path: '/edit_name',
      builder: (context, state) => edit_username(),
    ),
    GoRoute(
      path: '/edit_password',
      builder: (context, state) => EditPassword(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/addNewNotePage',
      builder: (context, state) => AddNewNotePage(),
    ),
    GoRoute(
        path: '/viewSpecificNote',
        builder: (context, state) => ViewSpecificNotePage()),
    GoRoute(
      path: '/editNoteScreen',
      builder: (context, state) => EditNoteScreen(),
    ),
    GoRoute(
      path: '/adminDashboard',
      builder: (context, state) => AdminDashboard(),
    ),
    // GoRoute(
    //   path: '/userDetail', builder: (context, state) => UserDetailScreen(user: ,),
    // ),
  ],
);
