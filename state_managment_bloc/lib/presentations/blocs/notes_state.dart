// lib/presentations/blocs/notes_state.dart
part of 'notes_bloc.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String errorMessage;

  NotesError(this.errorMessage);
}
