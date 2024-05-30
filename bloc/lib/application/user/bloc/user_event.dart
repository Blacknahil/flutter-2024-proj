part of 'user_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserProfile extends UserProfileEvent {
  final String userId;
  final String token;

  const FetchUserProfile(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];
}

class UpdateUsername extends UserProfileEvent {
  final String newUsername;

  const UpdateUsername(this.newUsername);

  @override
  List<Object> get props => [newUsername];
}

class ChangePassword extends UserProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePassword(
      this.oldPassword, this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class Logout extends UserProfileEvent {}

class ErrorOccured extends UserProfileEvent {
  final String message;

  const ErrorOccured(this.message);
}

class FolderCreatedSuccess extends UserProfileEvent {
  final String folderId;

  const FolderCreatedSuccess(this.folderId);

  @override
  List<Object> get props => [folderId];
}

class ClearMessages extends UserProfileEvent {}

class BanUser extends UserProfileEvent {
  final String userId;
  final String token;

  const BanUser(this.userId, this.token);
}

class DeleteAccount extends UserProfileEvent {}

class UnBanUser extends UserProfileEvent {
  final String userId;
  final String token;

  const UnBanUser(this.userId, this.token);
}

class DeleteUserAdmin extends UserProfileEvent {
  final String userId;
  final String token;

  const DeleteUserAdmin(this.userId, this.token);
}

class FetchAllUsers extends UserProfileEvent {
  final String token;

  const FetchAllUsers(this.token);
}
