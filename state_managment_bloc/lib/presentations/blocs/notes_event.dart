// lib/presentations/blocs/notes_event.dart
part of 'notes_bloc.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;

  AddNote({required this.note});
}

class DeleteNote extends NotesEvent {
  final Note note;

  DeleteNote({required this.note});
}

class UpdateNote extends NotesEvent {
  final Note note;

  UpdateNote({required this.note});
}
