import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/note/note.dart';
import '../../../domain/note/note_repository.dart';
import 'dart:developer' as devtools;

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc(this.noteRepository) : super(NoteInitial()) {
    on<CreateNote>(_onCreateNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<FetchNotesByFolder>(_onFetchNotesByFolder);
    on<ChangeCurrentNote>(_onChangeCurrentNote);
    on<FetchAllUserNotes>(_onFetchAllUserNotes);
    on<ErrorOccurred>(_onErrorOccurred);
  }

  Future<void> _onCreateNote(CreateNote event, Emitter<NoteState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesLoading());
      final result = await noteRepository.createNote(event.title, event.content,
          event.userId, event.folderId, event.token);
      result.fold(
        (failure) => emit(NotesError(failure.message)),
        (note) {
          final updatedNotes = List<Note>.from(currentState.notesArr)
            ..add(note);
          emit(NotesLoaded(updatedNotes,
              successMessage: "Note created successfully"));
        },
      );
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesLoading());
      final result = await noteRepository.updateNote(
          event.title, event.content, event.noteId, event.userId, event.token);
      result.fold(
        (failure) => emit(NotesError(failure.message)),
        (note) {
          final updatedNotes = currentState.notesArr
              .map((n) => n.id == note.id ? note : n)
              .toList();
          emit(NotesLoaded(updatedNotes,
              successMessage: "Note updated successfully"));
        },
      );
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      emit(NotesLoading());
      final result = await noteRepository.deleteNote(
          event.noteId, event.userId, event.token);
      result.fold(
        (failure) => emit(NotesError(failure.message)),
        (_) {
          final updatedNotes =
              currentState.notesArr.where((n) => n.id != event.noteId).toList();
          emit(NotesLoaded(updatedNotes,
              successMessage: "Note deleted successfully"));
        },
      );
    }
  }

  Future<void> _onFetchNotesByFolder(
      FetchNotesByFolder event, Emitter<NoteState> emit) async {
    // emit(NotesLoading());
    devtools.log("fetching Notes by folder");
    final result =
        await noteRepository.getNotesByFolder(event.folderId, event.token);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> _onChangeCurrentNote(
      ChangeCurrentNote event, Emitter<NoteState> emit) async {
    final currentState = state;
    if (currentState is NotesLoaded) {
      try {
        final currentNote =
            currentState.notesArr.firstWhere((n) => n.id == event.noteId);
        emit(NotesLoaded(currentState.notesArr, currentNote: currentNote));
      } catch (e) {
        emit(const NotesError("Note not found"));
      }
    }
  }

  Future<void> _onFetchAllUserNotes(
      FetchAllUserNotes event, Emitter<NoteState> emit) async {
    devtools.log("fetching all Notes");
    emit(NotesLoading());
    final result =
        await noteRepository.getAllUserNotes(event.userId, event.token);
    result.fold(
      (failure) => emit(NotesError(failure.message)),
      (notes) => emit(NotesLoaded(notes)),
    );
  }

  Future<void> _onErrorOccurred(
      ErrorOccurred event, Emitter<NoteState> emit) async {
    emit(NotesError(event.errorMessage));
  }
}
