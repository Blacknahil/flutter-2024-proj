import 'package:bloc_2/domain/user/failure_general.dart';
import 'package:bloc_2/domain/user/profile_failure.dart';
import 'package:bloc_2/domain/user/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<UserProfileFailure, Unit>> updateUsername(
      String userId, String newUsername, String token);
  Future<Either<UserProfileFailure, Unit>> changePassword(
      String userId,
      String newPassword,
      String oldPassword,
      String confirmPassword,
      String token);
  Future<Either<UserProfileFailure, Unit>> deleteAccount(
      String userId, String token, String role);
  Future<Either<UserProfileFailure, User>> fetchUserProfile(
      String userId, String token);

  Future<Either<GeneralFailure, List<User>>> getAllUsers(String token);
  Future<Either<GeneralFailure, Unit>> banUser(String userId, String token);
  Future<Either<GeneralFailure, Unit>> unBanUser(String userId, String token);
  Future<Either<GeneralFailure, Unit>> deleteUserAdmin(
      String userId, String token);
}
