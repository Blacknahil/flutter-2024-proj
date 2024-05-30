import 'dart:convert';

import 'package:bloc_2/domain/folder/folder_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../domain/folder/folder.dart';
import '../../domain/folder/folder_repository.dart';
import 'dart:developer' as devtools;

class FoldersRepositoryImpl implements FoldersRepository {
  final http.Client httpClient;
  final String baseUrl = 'http://localhost:5001';

  FoldersRepositoryImpl(this.httpClient);

  @override
  Future<Either<FolderFailure, List<Folder>>> getFolders(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/folders/all/$userId');
    // devtools.log("trying to fetch folders for $userId");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        // devtools.log("fetching folder success");

        List<dynamic> folderList = jsonDecode(response.body);
        // print("first encode passed");
        try {
          List<Folder> folders =
              folderList.map((item) => Folder.fromJson(item)).toList();
          // print("second encode passed");
          return Right(folders);
        } catch (e) {
          print(e);
          return left(FolderFailure(e.toString()));
        }
      } else {
        // devtools.log("fetching folder Failed");
        final error = jsonDecode(response.body);
        return left(FolderFailure(error));
      }
    } catch (e) {
      // devtools.log("fetching folder Failed");
      return Left(FolderFailure(e.toString()));
    }
  }

  @override
  Future<Either<FolderFailure, Folder>> createFolder(
      String name, String userId, String token) async {
    // devtools.log("name=$name userId=$userId and token=$token");
    final url = Uri.parse('$baseUrl/folders/$userId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'title': name,
        }),
      );
      devtools.log("folders repo imple result state  is $response.statusCode");
      if (response.statusCode == 201) {
        devtools.log("fetching folder success");
        try {
          final res = jsonDecode(response.body);
          // print('Response: $res');
          Folder folder = Folder.fromJson(res);
          return right(folder);
        } catch (e) {
          // print('Error decoding response: $e');
          return left(FolderFailure(e.toString()));
        }
      } else {
        final error = jsonDecode(response.body);
        return left(FolderFailure(error));
      }
    } catch (e) {
      return Left(FolderFailure(e.toString()));
    }
  }

  @override
  Future<Either<FolderFailure, Folder>> getOneFolder(
      String folderId, String token) async {
    final url = Uri.parse('$baseUrl/folders/one/$folderId');
    try {
      final response = await httpClient.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final folder = Folder.fromJson(jsonDecode(response.body));
        // devtools.log("successfully got the toched folder info");
        return right(folder);
      } else {
        final error = jsonDecode(response.body);
        // devtools.log("some error decoding ");
        return left(FolderFailure(error));
      }
    } catch (e) {
      // devtools.log("api error");
      return left(FolderFailure(e.toString()));
    }
  }
}
