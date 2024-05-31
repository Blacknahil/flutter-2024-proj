import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/notes_repository.dart';
import 'package:notes_app/domain/entities/note.dart';

part 'notes_admin_event.dart';
part 'notes_admin_state.dart';

class NotesAdminBloc extends Bloc<NotesAdminEvent, NotesAdminState> {
  final NotesRepository _notesRepository;

  NotesAdminBloc(this._notesRepository) : super(NotesAdminInitial());

  @override
  Stream<NotesAdminState> mapEventToState(NotesAdminEvent event) async* {
    if (event is LoadNotesAdmin) {
      yield NotesAdminLoading();
      try {
        final notes = await _notesRepository.getNotes();
        yield NotesAdminLoaded(notes);
      } catch (e) {
        yield NotesAdminError(e.toString());
      }
    } else if (event is AddAdminNote) {
      yield NotesAdminLoading();
      try {
        await _notesRepository.addNote(event.note);
        final notes = await _notesRepository.getNotes();
        yield NotesAdminLoaded(notes);
      } catch (e) {
        yield NotesAdminError(e.toString());
      }
    } else if (event is EditAdminNote) {
      yield NotesAdminLoading();
      try {
        await _notesRepository.updateNote(event.note);
        final notes = await _notesRepository.getNotes();
        yield NotesAdminLoaded(notes);
      } catch (e) {
        yield NotesAdminError(e.toString());
      }
    } else if (event is DeleteAdminNote) {
      yield NotesAdminLoading();
      try {
        await _notesRepository.deleteNote(event.note);
        final notes = await _notesRepository.getNotes();
        yield NotesAdminLoaded(notes);
      } catch (e) {
        yield NotesAdminError(e.toString());
      }
    }
  }
}
