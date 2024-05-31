// import 'dart:io';

// import 'package:bloc_2/domain/folder/folder.dart';
// import 'package:bloc_2/domain/folder/folder_repository.dart';
// import 'package:bloc_2/infrastructure/folders/folders_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;

// import 'package:dartz/dartz.dart';

// void main() {
//   late FoldersRepository folderRepository;

//   setUp(() {
//     folderRepository = FoldersRepositoryImpl(http.Client());
//   });

//   group('FolderRepository', () {
//     const userId = 'testUser';
//     const token = 'testToken';

//     test('should return a list of folders for a user', () async {
//       final result = await folderRepository.getFolders(userId, token);

//       expect(result.isRight(), true);
//       result.fold(
//         (l) => fail('Expected right but got left'),
//         (r) => expect(r, isA<List<Folder>>()),
//       );
//     });

//     test('should create a folder for a user', () async {
//       final result =
//           await folderRepository.createFolder('New Folder', userId, token);

//       expect(result.isRight(), true);
//       result.fold(
//         (l) => fail('Expected right but got left'),
//         (r) => expect(r, isA<Folder>()),
//       );
//     });

//     test('should return a single folder', () async {
//       final folderId = 'testFolder';
//       final result = await folderRepository.getOneFolder(folderId, token);

//       expect(result.isRight(), true);
//       result.fold(
//         (l) => fail('Expected right but got left'),
//         (r) => expect(r, isA<Folder>()),
//       );
//     });
//   });
// }
