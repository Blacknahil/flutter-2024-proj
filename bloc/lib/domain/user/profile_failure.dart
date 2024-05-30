import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_failure.freezed.dart';

enum UserProfileError {
  serverError,
  logoutFailed,
  authorizationError,
  userNotFound,
  passwordMismatch,
  invalidPassword,
}

@freezed
abstract class UserProfileFailure with _$UserProfileFailure {
  const factory UserProfileFailure.serverError() = ServerError;
  const factory UserProfileFailure.logoutFailed() = LogoutFailed;
  const factory UserProfileFailure.authorizationError() = AuthorizationError;
  const factory UserProfileFailure.userNotFound() = UserNotFound;
  const factory UserProfileFailure.passwordMismatch() = PasswordMismatch;
  const factory UserProfileFailure.invalidPassword() = InvalidPassword;
  const factory UserProfileFailure.jsonException(JSONException e) =
      JSONException;

  // UserProfileError get errorType {
  //   return when(
  //     serverError: () => UserProfileError.serverError,
  //     logoutFailed: () => UserProfileError.logoutFailed,
  //     authorizationError: () => UserProfileError.authorizationError,
  //     userNotFound: () => UserProfileError.userNotFound,
  //     passwordMismatch: () => UserProfileError.passwordMismatch,
  //     invalidPassword: () => UserProfileError.invalidPassword,
  //   );
  // }
}
