part of 'notes_admin_bloc.dart';

abstract class NotesAdminState {}

class NotesAdminInitial extends NotesAdminState {}

class NotesAdminLoading extends NotesAdminState {}

class NotesAdminLoaded extends NotesAdminState {
  final List<Note> notes;

  NotesAdminLoaded(this.notes);
}

class NotesAdminError extends NotesAdminState {
  final String errorMessage;

  NotesAdminError(this.errorMessage);
}
