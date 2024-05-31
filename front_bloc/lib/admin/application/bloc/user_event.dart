import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class BanUser extends UserEvent {
  final String userId;

  BanUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteUser extends UserEvent {
  final String userId;

  DeleteUser(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteNote extends UserEvent {
  final String userId;
  final String noteId;

  DeleteNote(this.userId, this.noteId);

  @override
  List<Object> get props => [userId, noteId];
}
