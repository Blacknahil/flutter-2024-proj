import 'package:dartz/dartz.dart';

import 'folder.dart';
import 'folder_failure.dart';

abstract class FoldersRepository {
  Future<Either<FolderFailure, List<Folder>>> getFolders(
      String userId, String token);
  Future<Either<FolderFailure, Folder>> createFolder(
      String name, String userId, String token);

  Future<Either<FolderFailure, Folder>> getOneFolder(
      String folderId, String token);
}
