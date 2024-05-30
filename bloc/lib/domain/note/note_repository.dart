import 'package:dartz/dartz.dart';

import 'note.dart';
import 'note_failure.dart';

abstract class NoteRepository {
  Future<Either<NoteFailure, List<Note>>> getNotesByFolder(
      String folderId, String token);
  Future<Either<NoteFailure, List<Note>>> getAllUserNotes(
      String userId, String token);
  Future<Either<NoteFailure, Note>> createNote(String title, String content,
      String userId, String folderId, String token);
  Future<Either<NoteFailure, Note>> updateNote(
      String title, String content, String noteId, String userId, String token);
  Future<Either<NoteFailure, Unit>> deleteNote(
      String noteId, String userId, String token);
}
