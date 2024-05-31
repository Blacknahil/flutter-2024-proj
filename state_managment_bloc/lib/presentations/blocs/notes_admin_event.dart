part of 'notes_admin_bloc.dart';

abstract class NotesAdminEvent {}

class LoadNotesAdmin extends NotesAdminEvent {}

class AddAdminNote extends NotesAdminEvent {
  final Note note;

  AddAdminNote({required this.note});
}

class EditAdminNote extends NotesAdminEvent {
  final Note note;

  EditAdminNote({required this.note});
}

class DeleteAdminNote extends NotesAdminEvent {
  final Note note;

  DeleteAdminNote({required this.note});
}
