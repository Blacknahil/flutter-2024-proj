// import 'package:bloc_2/infrastructure/folders/folders_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/testing.dart';
// import 'dart:convert';

// import 'package:bloc_2/domain/folder/folder.dart';
// import 'package:bloc_2/domain/folder/folder_failure.dart';
// import 'package:dartz/dartz.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mocktail/mocktail.dart';








  

// // void main() {
// //   late FoldersRepositoryImpl repository;
// //   late MockClient client;

// //   setUp(() {
// //     client = MockClient((request) async {
// //       if (request.method == 'GET' &&
// //           request.url.path.contains('/folders/all/')) {
// //         return http.Response(
// //             jsonEncode([
// //               {
// //                 'id': '1',
// //                 'title': 'Folder 1',
// //                 'noteIds': ['note1', 'note2']
// //               },
// //               {
// //                 'id': '2',
// //                 'title': 'Folder 2',
// //                 'noteIds': ['note3', 'note4']
// //               },
// //             ]),
// //             200);
// //       } else if (request.method == 'POST' &&
// //           request.url.path.contains('/folders/')) {
// //         return http.Response(
// //             jsonEncode({'id': '1', 'title': 'New Folder', 'noteIds': []}), 201);
// //       } else if (request.method == 'GET' &&
// //           request.url.path.contains('/folders/one/')) {
// //         return http.Response(
// //             jsonEncode({'id': '1', 'title': 'Single Folder', 'noteIds': []}),
// //             200);
// //       }
// //       return http.Response('Not Found', 404);
// //     });

// //     repository = FoldersRepositoryImpl(client);
// //   });

// //   group('FoldersRepositoryImpl', () {
// //     const userId = 'testUser';
// //     const token = 'testToken';

// //     test('should return a list of folders for a user', () async {
// //       final result = await repository.getFolders(userId, token);

// //       expect(result.isRight(), true);
// //       result.fold(
// //         (l) => fail('Expected right but got left'),
// //         (r) {
// //           expect(r, isA<List<Folder>>());
// //           expect(r.length, 2);
// //           expect(r[0].title, 'Folder 1');
// //           expect(r[1].title, 'Folder 2');
// //         },
// //       );
// //     });

//     // test('should create a folder for a user', () async {
//     //   final result = await repository.createFolder('New Folder', userId, token);

//     //   expect(result.isRight(), true);
//     //   result.fold(
//     //     (l) => fail('Expected right but got left'),
//     //     (r) => expect(r, isA<Folder>()),
//     //   );
//     // });

//     // test('should return a single folder', () async {
//     //   final folderId = 'testFolder';
//     //   final result = await repository.getOneFolder(folderId, token);

//     //   expect(result.isRight(), true);
//     //   result.fold(
//     //     (l) => fail('Expected right but got left'),
//     //     (r) => expect(r, isA<Folder>()),
//     //   );
//     // });

//     // test('should handle failure when fetching folders', () async {
//     //   client = MockClient((request) async {
//     //     return http.Response('Internal Server Error', 500);
//     //   });
//     //   repository = FoldersRepositoryImpl(client);

//     //   final result = await repository.getFolders(userId, token);

//     //   expect(result.isLeft(), true);
//     //   result.fold(
//     //     (l) => expect(l, isA<FolderFailure>()),
//     //     (r) => fail('Expected left but got right'),
//     //   );
//     // });

//     // test('should handle failure when creating a folder', () async {
//     //   client = MockClient((request) async {
//     //     return http.Response('Internal Server Error', 500);
//     //   });
//     //   repository = FoldersRepositoryImpl(client);

//     //   final result = await repository.createFolder('New Folder', userId, token);

//     //   expect(result.isLeft(), true);
//     //   result.fold(
//     //     (l) => expect(l, isA<FolderFailure>()),
//     //     (r) => fail('Expected left but got right'),
//     //   );
//     // });

//     // test('should handle failure when fetching a single folder', () async {
//     //   client = MockClient((request) async {
//     //     return http.Response('Internal Server Error', 500);
//     //   });
//     //   repository = FoldersRepositoryImpl(client);

//     //   final folderId = 'testFolder';
//     //   final result = await repository.getOneFolder(folderId, token);

//     //   expect(result.isLeft(), true);
//     //   result.fold(
//     //     (l) => expect(l, isA<FolderFailure>()),
//     //     (r) => fail('Expected left but got right'),
//     //   );
//     // });
//   });
// }
