import 'package:notes_app/note/domain/model/note.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<Note> notes;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.notes,
  });
}
