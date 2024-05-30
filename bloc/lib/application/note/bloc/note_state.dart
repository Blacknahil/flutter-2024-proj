part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

final class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<Note> notesArr;
  final Note? currentNote;
  final String? successMessage;

  const NotesLoaded(this.notesArr, {this.currentNote, this.successMessage});

  @override
  List<Object?> get props => [notesArr, currentNote, successMessage];
}

class NotesError extends NoteState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}
