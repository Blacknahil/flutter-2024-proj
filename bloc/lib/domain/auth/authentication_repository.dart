// lib/domain/auth/repository/authentication_repository.dart

import 'dart:async';

import 'package:bloc_2/domain/user/user.dart';
import 'package:dartz/dartz.dart';

import '../core/auth_failure.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> get status;
  Future<Either<AuthFailure, Tuple2<String, String>>> logIn(
      {required String email, required String password});
  Future<Either<AuthFailure, Unit>> register(
      String email, String password, String firstname,
      [String lastname = '']);
  void logOut();
  void dispose();
  Future<User?> getUser();
  Future<void> deleteUser();
}
