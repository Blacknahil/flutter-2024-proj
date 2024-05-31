// lib/infrastructure/user/user_repository_impl.dart
import 'dart:convert';

import 'package:bloc_2/domain/user/failure_general.dart';
import 'package:bloc_2/domain/user/profile_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools;

import '../../domain/user/user.dart';
import '../../domain/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final http.Client httpClient;
  // final String baseUrl = 'http://localhost:5001';
  final String baseUrl = 'http://10.0.2.2:5001';

  UserRepositoryImpl({required this.httpClient});

  @override
  Future<Either<UserProfileFailure, Unit>> updateUsername(
      String userId, String newUsername, String token) async {
    final url = Uri.parse('$baseUrl/users/update/$userId');
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'name': newUsername}),
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final error = json.decode(response.body);
        if (error['message'] == 'User not found') {
          return left(const UserProfileFailure.userNotFound());
        } else {
          return left(const UserProfileFailure.serverError());
        }
      }
    } catch (e) {
      return left(const UserProfileFailure.serverError());
    }
  }

  @override
  Future<Either<UserProfileFailure, Unit>> changePassword(
      String userId,
      String newPassword,
      String oldPassword,
      String confirmPassword,
      String token) async {
    final url = Uri.parse('$baseUrl/users/update/$userId');
    devtools.log(oldPassword);
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'newPassword': newPassword,
          'oldPassword': oldPassword,
          'confirmPassword': confirmPassword
        }),
      );
      devtools.log("$response.statusCode");
      print(response.body);

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        final error = json.decode(response.body);
        if (error['message'] ==
            "New password and confirm password dont match") {
          return left(const UserProfileFailure.passwordMismatch());
        } else if (error['message'] == "Old password is incorrect") {
          return left(const UserProfileFailure.invalidPassword());
        } else {
          return left(const UserProfileFailure.serverError());
        }
      }
    } catch (e) {
      return left(const UserProfileFailure.serverError());
    }
  }

  @override
  Future<Either<UserProfileFailure, User>> fetchUserProfile(
      String userId, String token) async {
    print("Trying to fetch user id $userId and token $token");
    final url = Uri.parse('$baseUrl/users/profile/$userId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token'
        },
      );
      devtools.log("Fetching profile status code is: ${response.statusCode}");
      // print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final user = User.fromJson(userData);
        devtools.log('user is fetched $user');
        return right(user);
      } else {
        final error = jsonDecode(response.body);
        if (error['message'] == 'User not found') {
          return left(const UserProfileFailure.userNotFound());
        } else {
          return left(const UserProfileFailure.serverError());
        }
      }
    } catch (e) {
      print("Exception: $e");
      return left(const UserProfileFailure.serverError());
    }
  }

  @override
  //generate a delete account call
  Future<Either<UserProfileFailure, Unit>> deleteAccount(
      String userId, String token, String role) async {
    final url = Uri.parse('$baseUrl/users/delete/$userId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'role': role}),
      );
      devtools.log("trying to delete Account");
      devtools.log('$response.statusCode');

      if (response.statusCode == 200) {
        devtools.log("delete successful");
        return right(unit);
      } else {
        devtools.log("delete Unsuccessful");
        final error = json.decode(response.body);
        if (error['message'] == 'User not found') {
          return left(const UserProfileFailure.userNotFound());
        } else {
          return left(const UserProfileFailure.serverError());
        }
      }
    } catch (e) {
      devtools.log("delete Unsuccessful");
      return left(const UserProfileFailure.serverError());
    }
  }

  @override
  Future<Either<GeneralFailure, List<User>>> getAllUsers(String token) async {
    final url = Uri.parse('$baseUrl/admin/allwithnotes');
    try {
      final response = await httpClient.get(url, headers: {
        'Content-Type': 'application',
        'Authorization': "Bearer $token",
      });
      devtools.log("trying to get All users");
      if (response.statusCode == 200) {
        devtools.log("got all users : Trying to decode response");
        try {
          final Map<String, dynamic> usersMap = json.decode(response.body);
          final users =
              usersMap.values.map((json) => User.fromJson(json)).toList();
          devtools.log("successfully decoded response");
          return Right(users);
        } catch (e) {
          devtools.log("Error decoding response: $e");
          return Left(GeneralFailure('Failed to fetch users'));
        }
      } else {
        devtools.log("user repository response failed");
        return Left(GeneralFailure('Failed to fetch users'));
      }
    } catch (e) {
      return Left(GeneralFailure('An error occurred while fetching users: $e'));
    }
  }

  @override
  Future<Either<GeneralFailure, Unit>> banUser(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/admin/user/ban/$userId');
    try {
      final response = await httpClient.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return const Right(unit);
      } else {
        return Left(GeneralFailure('Failed to ban user'));
      }
    } catch (e) {
      return Left(GeneralFailure('An error occurred while banning user: $e'));
    }
  }

  @override
  Future<Either<GeneralFailure, Unit>> unBanUser(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/admin/user/unban/$userId');
    try {
      final response = await httpClient.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        devtools.log('User unbanned');
        return const Right(unit);
      } else {
        devtools.log('User unbann unsuccessful');
        return Left(GeneralFailure('Failed to Unban user'));
      }
    } catch (e) {
      devtools.log('User unbann Unsuccessful');
      return Left(GeneralFailure('An error occurred while banning user: $e'));
    }
  }

  @override
  Future<Either<GeneralFailure, Unit>> deleteUserAdmin(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/admin/user/$userId');
    try {
      final response = await httpClient.delete(
        url,
        headers: {
          'Content-Type': 'application',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        devtools.log('User deleted');
        return const Right(unit);
      } else {
        devtools.log('User delete unsuccessful');
        return Left(GeneralFailure('Failed to delete user'));
      }
    } catch (e) {
      devtools.log('User delete unsuccessful');
      return Left(GeneralFailure('An error occurred while deleting user: $e'));
    }
  }
}
