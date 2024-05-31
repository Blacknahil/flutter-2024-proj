import 'package:notes_app/admin/domain/models/note.dart';

class NoteService {
  List<Note> getNotesForUser(String userId) {
    // This should be replaced with real data fetching logic
    return [
      Note(
        title: 'Note 1',
        id: 'n1',
        content: 'Note 1 content',
      ),
      Note(
        title: 'Note 1',
        id: 'n2',
        content: 'Note 2 content',
      ),
    ];
  }

  void deleteNoteForUser(String userId, String noteId) {
    // Implement delete note logic
  }
}
