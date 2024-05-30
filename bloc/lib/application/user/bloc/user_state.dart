part of 'user_bloc.dart';

class UserProfileState extends Equatable {
  final String name;
  final String email;
  final String userId;
  final bool loggedIn;
  final bool banned;
  final List<String> folderIds;
  final bool isProfileFetched;
  final String token;
  final String role;
  final String? errorMessage;
  final String? successMessage;

  const UserProfileState({
    required this.name,
    required this.email,
    required this.userId,
    required this.loggedIn,
    required this.banned,
    required this.folderIds,
    required this.isProfileFetched,
    required this.token,
    required this.role,
    this.errorMessage,
    this.successMessage,
  });

  UserProfileState copyWith({
    String? name,
    String? email,
    String? userId,
    bool? loggedIn,
    bool? banned,
    List<String>? folderIds,
    bool? isProfileFetched,
    String? token,
    String? role,
    String? errorMessage,
    String? successMessage,
  }) {
    return UserProfileState(
      name: name ?? this.name,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      loggedIn: loggedIn ?? this.loggedIn,
      banned: banned ?? this.banned,
      folderIds: folderIds ?? this.folderIds,
      isProfileFetched: isProfileFetched ?? this.isProfileFetched,
      token: token ?? this.token,
      role: role ?? this.role,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        userId,
        loggedIn,
        banned,
        folderIds,
        isProfileFetched,
        token,
        role,
        errorMessage,
        successMessage,
      ];
}

class UserProfileInitial extends UserProfileState {
  UserProfileInitial()
      : super(
          name: '',
          email: '',
          userId: '',
          loggedIn: false,
          banned: false,
          folderIds: [],
          isProfileFetched: false,
          role: '',
          token: '',
        );
}

class UsersLoaded extends UserProfileState {
  final List<User> users;

  UsersLoaded({
    required List<User> users,
    required String name,
    required String email,
    required String userId,
    required bool loggedIn,
    required bool banned,
    required List<String> folderIds,
    required bool isProfileFetched,
    required String token,
    required String role,
    String? errorMessage,
    String? successMessage,
  })  : users = users,
        super(
          name: name,
          email: email,
          userId: userId,
          loggedIn: loggedIn,
          banned: banned,
          folderIds: folderIds,
          isProfileFetched: isProfileFetched,
          token: token,
          role: role,
          errorMessage: errorMessage,
          successMessage: successMessage,
        );

  @override
  List<Object?> get props => [
        users,
        name,
        email,
        userId,
        loggedIn,
        banned,
        folderIds,
        isProfileFetched,
        token,
        role,
        errorMessage,
        successMessage,
      ];
}



// class UserProfileDeleteSuccess extends UserProfileState {
//   UserProfileDeleteSuccess()
//       : super(
//           name: '',
//           email: '',
//           userId: '',
//           loggedIn: false,
//           banned: false,
//           folderIds: [],
//           isProfileFetched: false,
//           role: '',
//         );
// }

// class UserProfilePasswordChangeSuccess extends UserProfileState {
//   UserProfilePasswordChangeSuccess()
//       : super(
//           name: '',
//           email: '',
//           userId: '',
//           loggedIn: false,
//           banned: false,
//           folderIds: [],
//           isProfileFetched: false,
//         );
// }

