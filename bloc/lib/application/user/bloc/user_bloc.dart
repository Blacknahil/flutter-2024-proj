import 'package:bloc_2/application/note/bloc/note_bloc.dart';
import 'package:bloc_2/domain/user/profile_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../domain/user/user.dart';
import '../../../domain/user/user_repository.dart';
import 'dart:developer' as devtools;

part 'user_event.dart';
part 'user_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserRepository userRepository;

  static UserProfileBloc of(BuildContext context) {
    return BlocProvider.of<UserProfileBloc>(context);
  }

  UserProfileBloc({required this.userRepository})
      : super(UserProfileInitial()) {
    on<FetchUserProfile>(_onFetchUserProfile);
    on<UpdateUsername>(_onUpdateUsername);
    on<ChangePassword>(_onChangePassword);
    on<DeleteAccount>(_onDeleteAccount);
    on<Logout>(_onLogout);
    on<ErrorOccured>(_onErrorOccured);
    on<ClearMessages>(_onClearMessages);
    on<FetchAllUsers>(_onFetchAllUsers);
    on<BanUser>(_onBanUser);
    on<UnBanUser>(_onUnBanUser);
    on<DeleteUserAdmin>(_onDeleteUserAdmin);
  }

  Future<void> _onFetchUserProfile(
      FetchUserProfile event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(isProfileFetched: false));
    devtools.log("Fetching user profile for user: ${event.userId}");
    final result =
        await userRepository.fetchUserProfile(event.userId, event.token);
    print(result);
    result.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.toString())),
        (user) {
      emit(
        state.copyWith(
          name: user.name,
          email: user.email,
          userId: event.userId,
          token: event.token,
          loggedIn: true,
          role: user.role,
          banned: user.banned,
          folderIds: user.folders,
          isProfileFetched: true,
          successMessage: "Profile fetched successfully",
          errorMessage: null,
        ),
      );
      // devtools.log("User role is ${user.role}");
      // devtools.log("${"admin" == user.role}");
      // if (user.role == "admin") {
      //   devtools.log("triggering fetch all users");
      //   add(FetchAllUsers(user.));
      //   devtools.log("going to admin dashboard");
      //   router.go('/adminDashboard');
      // } else {
      //   devtools.log("going to home page");
      //   router.go('/adminDashboard');
      // }
    });
  }

  Future<void> _onUpdateUsername(
      UpdateUsername event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.updateUsername(
        state.userId, event.newUsername, state.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (_) => emit(state.copyWith(
          name: event.newUsername,
          errorMessage: null,
          successMessage: "Username updated successfully")),
    );
  }

  Future<void> _onChangePassword(
      ChangePassword event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.changePassword(
        state.userId,
        event.newPassword,
        event.oldPassword,
        event.confirmPassword,
        state.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (_) => emit(state.copyWith(
          errorMessage: null, successMessage: "Password changed successfully")),
    );
  }

  Future<void> _onDeleteAccount(
      DeleteAccount event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.deleteAccount(
        state.userId, state.token, state.role);
    result.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.toString())),
        (_) => emit(state.copyWith(
              name: '',
              email: '',
              userId: '',
              loggedIn: false,
              banned: false,
              folderIds: [],
              isProfileFetched: false,
              token: '',
              role: '',
              errorMessage: null,
              successMessage: "Successfully Deleted Account",
            )));
  }

  void _onErrorOccured(ErrorOccured event, Emitter<UserProfileState> emit) {
    _handleError(event.message, emit);
  }

  void _handleError(String message, Emitter<UserProfileState> emit) {
    add(ErrorOccured(message));
  }

  Future<void> _onLogout(Logout event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(
      name: '',
      email: '',
      userId: '',
      loggedIn: false,
      banned: false,
      folderIds: [],
      isProfileFetched: false,
      token: '',
      role: '',
      errorMessage: null,
      successMessage: "Successfully logged out",
    ));
  }

  void _onClearMessages(ClearMessages event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  Future<void> _onFetchAllUsers(
      FetchAllUsers event, Emitter<UserProfileState> emit) async {
    devtools.log("user bloc fetch all users with token ${event.token}");
    final result = await userRepository.getAllUsers(state.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (users) => emit(UsersLoaded(
        users: users,
        name: state.name,
        email: state.email,
        userId: state.userId,
        loggedIn: state.loggedIn,
        banned: state.banned,
        folderIds: state.folderIds,
        isProfileFetched: state.isProfileFetched,
        token: state.token,
        role: state.role,
      )),
    );
  }

  Future<void> _onBanUser(BanUser event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.banUser(event.userId, event.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (_) {
        final currentState = state;
        if (currentState is UsersLoaded) {
          final updatedUsers = currentState.users
              .map((user) =>
                  user.id == event.userId ? user.copyWith(banned: true) : user)
              .toList();
          emit(UsersLoaded(
            users: updatedUsers,
            name: currentState.name,
            email: currentState.email,
            userId: currentState.userId,
            loggedIn: currentState.loggedIn,
            banned: currentState.banned,
            folderIds: currentState.folderIds,
            isProfileFetched: currentState.isProfileFetched,
            token: currentState.token,
            role: currentState.role,
          ));
          emit(state.copyWith(successMessage: "User banned successfully"));
        }
      },
    );
  }

  Future<void> _onUnBanUser(
      UnBanUser event, Emitter<UserProfileState> emit) async {
    final result = await userRepository.unBanUser(event.userId, event.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (_) {
        final currentState = state;
        if (currentState is UsersLoaded) {
          final updatedUsers = currentState.users
              .map((user) =>
                  user.id == event.userId ? user.copyWith(banned: false) : user)
              .toList();
          emit(UsersLoaded(
            users: updatedUsers,
            name: currentState.name,
            email: currentState.email,
            userId: currentState.userId,
            loggedIn: currentState.loggedIn,
            banned: currentState.banned,
            folderIds: currentState.folderIds,
            isProfileFetched: currentState.isProfileFetched,
            token: currentState.token,
            role: currentState.role,
          ));
          emit(state.copyWith(successMessage: "User Unbanned successfully"));
        }
      },
    );
  }

  Future<void> _onDeleteUserAdmin(
      DeleteUserAdmin event, Emitter<UserProfileState> emit) async {
    final result =
        await userRepository.deleteUserAdmin(event.userId, event.token);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.toString())),
      (_) {
        final currentState = state;
        if (currentState is UsersLoaded) {
          final updatedUsers = currentState.users
              .where((user) => user.id != event.userId)
              .toList();
          emit(UsersLoaded(
            users: updatedUsers,
            name: currentState.name,
            email: currentState.email,
            userId: currentState.userId,
            loggedIn: currentState.loggedIn,
            banned: currentState.banned,
            folderIds: currentState.folderIds,
            isProfileFetched: currentState.isProfileFetched,
            token: currentState.token,
            role: currentState.role,
          ));
        }
      },
    );
  }
}
