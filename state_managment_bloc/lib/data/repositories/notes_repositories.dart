// lib/data/repositories/notes_repository.dart
import 'package:notes_app/domain/entities/note.dart';

class NotesRepository {
  List<Note> _notes = [];

  Future<List<Note>> getNotes() async {
    // Fetch notes from a database or API (in this case, in-memory)
    return _notes;
  }

  Future<void> addNote(Note note) async {
    _notes.add(note);
    // Simulate database update or API call
    await Future.delayed(Duration(milliseconds: 500));
  }

  Future<void> updateNote(Note note) async {
    // Find and update the note in the list
    // Simulate database update or API call
    await Future.delayed(Duration(milliseconds: 500));
  }

  Future<void> deleteNote(Note note) async {
    _notes.remove(note);
    // Simulate database update or API call
    await Future.delayed(Duration(milliseconds: 500));
  }
}
