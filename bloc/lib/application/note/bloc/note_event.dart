part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class CreateNote extends NoteEvent {
  final String title;
  final String content;
  final String userId;
  final String folderId;
  final String token;

  const CreateNote(
      this.title, this.content, this.userId, this.folderId, this.token);

  @override
  List<Object?> get props => [title, content, userId, folderId, token];
}

class UpdateNote extends NoteEvent {
  final String title;
  final String content;
  final String noteId;
  final String userId;
  final String token;

  const UpdateNote(
      this.title, this.content, this.noteId, this.userId, this.token);

  @override
  List<Object?> get props => [title, content, noteId, userId, token];
}

class FetchAllUserNotes extends NoteEvent {
  final String userId;
  final String token;

  const FetchAllUserNotes(this.userId, this.token);

  @override
  List<Object?> get props => [userId, token];
}

class DeleteNote extends NoteEvent {
  final String noteId;
  final String userId;
  final String token;

  const DeleteNote(this.noteId, this.userId, this.token);

  @override
  List<Object?> get props => [noteId, userId, token];
}

class FetchNotesByFolder extends NoteEvent {
  final String folderId;
  final String token;

  const FetchNotesByFolder(this.folderId, this.token);

  @override
  List<Object?> get props => [folderId, token];
}

class ChangeCurrentNote extends NoteEvent {
  final String noteId;
  final String token;

  const ChangeCurrentNote(this.noteId, this.token);

  @override
  List<Object?> get props => [noteId, token];
}

class ErrorOccurred extends NoteEvent {
  final String errorMessage;

  const ErrorOccurred(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
