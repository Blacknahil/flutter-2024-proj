import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bloc_2/domain/core/auth_failure.dart';

import 'package:bloc_2/domain/core/valid_objects.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/i_auth_facade.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NestJsIAuthFacade implements IAuthFacade {
  // final GoogleSignIn _googleSignIn;

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    final respose = await http.post(
      Uri.parse('http://localhost:5001/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailAddressStr,
        'password': passwordStr,
      }),
    );
    if (respose.statusCode == 200) {
      return right(unit);
    } else if (respose.statusCode == 409) {
      return left(const AuthFailure.emailAlreadyInUse());
    } else {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    final respose = await http.post(
      Uri.parse('http://localhost:5001/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailAddressStr,
        'password': passwordStr,
      }),
    );
    if (respose.statusCode == 200) {
      return right(unit);
    } else if (respose.statusCode == 401) {
      return left(const AuthFailure.invalidEmailAndPasswordCombination());
    } else {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    //   try{
    //     final googleUser = await _googleSignIn.signIn();
    //     if(googleUser == null){
    //       return left(const AuthFailure.cancelledByUser());
    //     }
    //     final googleAuth = await googleUser.authentication;
    //     final authCredential = GoogleAuthProvider.credential(
    //       accessToken: googleAuth.accessToken,
    //       idToken: googleAuth.idToken,
    //     );
    //     return left(const AuthFailure.serverError());

    //   }
    //   on PlatformException catch (_) {
    //     return left(const AuthFailure.serverError());
    // }
    throw UnimplementedError();
  }
}
