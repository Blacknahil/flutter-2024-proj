import '../../../domain/user/user.dart';

abstract class UserRepository {
  List<User> getUsers();
  void banUser(String userId);
  void deleteUser(String userId);
  void deleteNote(String userId, String noteId);
}
