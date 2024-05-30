// lib/infrastructure/authentication/auth_repository_impl.dart

import 'dart:async';
import 'dart:convert';

import 'package:bloc_2/domain/user/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../application/user/bloc/user_bloc.dart';
import '../../domain/core/auth_failure.dart';
import '../../domain/note/note.dart';
import '../../domain/user/user.dart';
import '../../domain/auth/authentication_repository.dart';
import '../shared_preference/shared_preference.dart';
import 'dart:developer' as devtools;

class AuthRepositoryImpl implements AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  final UserProfileBloc userProfileBloc;
  final UserRepository userRepository;

  AuthRepositoryImpl({
    required this.userProfileBloc,
    required this.userRepository,
  });

  final String baseUrl =
      'http://localhost:5001/users'; // Replace with your actual API base URL

  @override
  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  //login method

  @override
  Future<Either<AuthFailure, Tuple2<String, String>>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // devtools.log('attempting login $email and $password');
      // devtools.log(response as String);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        try {
          final Map<String, dynamic> userData = json.decode(response.body);
          final userId = userData['userId'] as String;
          final token = userData['access_token'] as String;
          _controller.add(AuthenticationStatus.authenticated);

          return right(Tuple2(userId, token));
        } catch (e) {
          return left(AuthFailure.jsonException(e.toString() as JSONException));
        }
      } else {
        final error = json.decode(response.body);
        if (error['message'] == 'Invalid credentials' ||
            error['message'] == 'Incorrect email' ||
            error['message'] == '"Incorrect password') {
          return left(const AuthFailure.invalidEmailAndPasswordCombination());
        } else {
          // devtools.log(response.body);
          return left(const AuthFailure.serverError());
        }
      }
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  //register

  @override
  Future<Either<AuthFailure, Unit>> register(
      String email, String password, String firstname,
      [String lastname = '']) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      final response = await http.post(
        url,
        body: json.encode({
          'name': firstname + ' ' + lastname,
          'email': email,
          'password': password
        }),
        headers: {'Content-Type': 'application/json'},
      );
      // devtools.log(response.statusCode.toString());

      if (response.statusCode == 201) {
        _controller.add(AuthenticationStatus.authenticated);
        return right(unit);
      } else if (response.statusCode == 409) {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> logOut() async {
    await SharedPreferencesService.clearSession();
    await SharedPreferencesService.clearAccessToken(); // Clear the access token
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<User?> getUser() async {
    // Retrieve signed-in user data from SharedPreferences
    final userData = await SharedPreferencesService.getSession();
    if (userData.isNotEmpty) {
      // If user data is available, create and return a User object
      List<String> folders =
          List<String>.from(json.decode(userData['folders']!) as List);
      return User(
        id: userData['userId']!,
        email: userData['email']!,
        name: userData['username']!,
        folders: folders,
        banned: false,
        role: userData['role']!,
      );
    } else {
      // If no user data is found, return null
      return null;
    }
  }

//delete user account
  @override
  Future<void> deleteUser() async {
    try {
      final userData = await SharedPreferencesService.getSession();
      final userId = userData['userId'];

      if (userId != null) {
        final url = Uri.parse('$baseUrl/delete/$userId');
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          await SharedPreferencesService.clearSession();
        } else {
          // Handle error response from the backend
          throw Exception(
              'Failed to delete user account: ${response.reasonPhrase}');
        }
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      throw Exception('Failed to delete user account: $e');
    }
  }

  @override
  void dispose() {
    SharedPreferencesService.clearSession();
    _controller.add(AuthenticationStatus.unauthenticated);
    _controller.close();
  }
}
