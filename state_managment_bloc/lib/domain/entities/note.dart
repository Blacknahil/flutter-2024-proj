// lib/domain/entities/note.dart
class Note {
  final String title;
  final String body;
  final bool isFavorite;

  Note({required this.title, required this.body, this.isFavorite = false});
}
