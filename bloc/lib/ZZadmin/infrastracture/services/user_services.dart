import 'package:bloc_2/domain/note/note.dart';

import '../../../domain/user/user.dart';

class UserService {
  List<User> getUsers() {
    // This should be replaced with real data fetching logic
    return [
      User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        banned: false,
        role: '',
        folders: [],
      ),
      // Add more users
    ];
  }

  void banUser(String userId) {
    // Implement ban user logic
  }

  void deleteUser(String userId) {
    // Implement delete user logic
  }

  void deleteNote(String userId, String noteId) {
    // Implement delete note logic
  }
}
