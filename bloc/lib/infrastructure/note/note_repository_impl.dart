import 'package:bloc_2/application/note/bloc/note_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as devtools;

import '../../domain/note/note.dart';
import '../../domain/note/note_failure.dart';
import '../../domain/note/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final http.Client httpClient;
  // final String baseUrl = 'http://localhost:5001';
  final String baseUrl = 'http://10.0.2.2:5001';

  NoteRepositoryImpl(this.httpClient);

  @override
  Future<Either<NoteFailure, List<Note>>> getNotesByFolder(
      String folderId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/folders/notes/$folderId');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      devtools.log("Response for getNotesByFoder is $response.statusCode");
      if (response.statusCode == 200) {
        devtools.log("trying to json the note");
        try {
          final notes = (json.decode(response.body) as List)
              .map((json) => Note.fromJson(json))
              .toList();
          devtools.log(" json the note Success");
          return right(notes);
        } catch (e) {
          devtools.log(e.toString());
          return left(NoteFailure(e.toString()));
        }
      } else {
        devtools.log("Notes json failed");
        return left(NoteFailure('Failed to Jsonify notes'));
      }
    } catch (e) {
      devtools.log(e.toString());
      return left(NoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<NoteFailure, List<Note>>> getAllUserNotes(
      String userId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/notes');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
          'user-id': userId,
        },
      );
      devtools.log("getting all user notes status: $response.statusCode");

      if (response.statusCode == 200) {
        devtools.log("success for getting all users notes");
        devtools.log("trying to decode the response");
        final notes = (json.decode(response.body) as List)
            .map((json) => Note.fromJson(json))
            .toList();
        devtools.log("decoding json success");
        return right(notes);
      } else {
        devtools.log("failed to decode json");
        return left(NoteFailure('Failed to decode response notes'));
      }
    } catch (e) {
      devtools.log(e.toString());
      return left(NoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<NoteFailure, Note>> createNote(
    String title,
    String content,
    String userId,
    String folderId,
    String token,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/notes');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'user-id': userId,
          'folder-id': folderId,
        },
        body: json.encode({
          'title': title,
          'content': content,
        }),
      );

      devtools.log("trying to create a note");
      if (response.statusCode == 201) {
        devtools.log("Note creation Success trying to decode Json");
        try {
          final createdNote = Note.fromJson(json.decode(response.body));
          devtools.log("decoding successful");
          return right(createdNote);
        } catch (e) {
          final error = jsonDecode(response.body);
          devtools.log(error);
          return left(NoteFailure(error));
        }
      } else {
        devtools.log("api request error");
        return left(NoteFailure('Failed to create note'));
      }
    } catch (e) {
      return left(NoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<NoteFailure, Note>> updateNote(String title, String content,
      String noteId, String userId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/notes/$noteId');
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'user-id': userId,
        },
        body: json.encode({
          'title': title,
          'content': content,
        }),
      );
      devtools.log("updating a note");
      if (response.statusCode == 200) {
        devtools.log("update successful");
        devtools.log("trying to decode note");
        try {
          final updatedNote = Note.fromJson(json.decode(response.body));
          devtools.log("error decoding json");
          return right(updatedNote);
        } catch (e) {
          final error = jsonDecode(response.body);
          devtools.log(error);
          return left(NoteFailure(error));
        }
      } else {
        return left(NoteFailure('Failed to update note'));
      }
    } catch (e) {
      return left(NoteFailure(e.toString()));
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> deleteNote(
      String noteId, String userId, String token) async {
    try {
      final url = Uri.parse('$baseUrl/notes/$noteId');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'user-id': userId,
        },
      );

      devtools.log("trying to delete a note");

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(NoteFailure('Failed to delete note'));
      }
    } catch (e) {
      return left(NoteFailure(e.toString()));
    }
  }
}
