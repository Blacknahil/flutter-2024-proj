import 'package:bloc_2/ZZadmin/domain/user/user_repository.dart';
import 'package:bloc_2/ZZadmin/infrastracture/services/user_services.dart';

import '../../../domain/user/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  List<User> getUsers() {
    return _userService.getUsers();
  }

  @override
  void banUser(String userId) {
    _userService.banUser(userId);
  }

  @override
  void deleteUser(String userId) {
    _userService.deleteUser(userId);
  }

  @override
  void deleteNote(String userId, String noteId) {
    _userService.deleteNote(userId, noteId);
  }
}
