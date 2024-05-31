
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesNotifier extends ChangeNotifier{
  List notesList = [];
  void onSaveNote(String note){
    notesList.add(note);
    notifyListeners();
  }

  void onRemoveNotes(int index){
    notesList.removeAt(index);
    notifyListeners();
  }
}


final notesProvider = ChangeNotifierProvider<NotesNotifier>((ref) {
  return  NotesNotifier();
},);