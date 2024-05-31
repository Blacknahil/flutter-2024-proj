import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/admin/domain/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = userRepository.getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<BanUser>((event, emit) async {
      try {
        userRepository.banUser(event.userId);
        add(LoadUsers());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      try {
        userRepository.deleteUser(event.userId);
        add(LoadUsers());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        userRepository.deleteNote(event.userId, event.noteId);
        add(LoadUsers());
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
