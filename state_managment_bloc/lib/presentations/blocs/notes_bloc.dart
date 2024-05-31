// lib/presentations/blocs/notes_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';
import 'package:notes_app/domain/entities/note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc(this._notesRepository) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<DeleteNote>(_onDeleteNote);
    on<UpdateNote>(_onUpdateNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await _notesRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await _notesRepository.addNote(event.note);
      final notes = await _notesRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await _notesRepository.deleteNote(event.note);
      final notes = await _notesRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      await _notesRepository.updateNote(event.note);
      final notes = await _notesRepository.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
