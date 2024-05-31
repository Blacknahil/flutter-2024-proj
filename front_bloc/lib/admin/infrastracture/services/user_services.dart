import 'package:notes_app/note/domain/model/note.dart';
import 'package:notes_app/user/domain/model/user.dart';

class UserService {
  List<User> getUsers() {
    // This should be replaced with real data fetching logic
    return [
      User(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        notes: [
          Note(
              id: 'n1',
              content: 'Note 1 content',
              title: "Note 1",
              String: null),
          Note(
            id: 'n2',
            title: "Note 2",
            content: 'Note 2 content',
            String: null,
          ),
        ],
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
