import 'package:notes_app/admin/domain/repositories/user_repository.dart';
import 'package:notes_app/admin/infrastracture/services/user_services.dart';

import '../../../user/domain/model/user.dart';

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
