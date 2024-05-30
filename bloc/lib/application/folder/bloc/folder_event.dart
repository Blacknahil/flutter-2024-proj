part of 'folder_bloc.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();
  @override
  List<Object> get props => [];
}

class FetchFolders extends FolderEvent {
  final String userId;
  final String token;

  const FetchFolders(this.userId, this.token);

  @override
  List<Object> get props => [userId];
}

class CreateFolder extends FolderEvent {
  final String title;
  final String userId;
  final String token;

  const CreateFolder(this.title, this.userId, this.token);

  @override
  List<Object> get props => [title, userId, token];
}

class ChangeCurrentFolder extends FolderEvent {
  final String folderId;
  final String token;

  const ChangeCurrentFolder(this.folderId, this.token);

  @override
  List<Object> get props => [folderId, token];
}
