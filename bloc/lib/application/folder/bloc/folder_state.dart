part of 'folder_bloc.dart';

abstract class FolderState extends Equatable {
  const FolderState();

  @override
  List<Object?> get props => [];
}

final class FolderInitial extends FolderState {}

class FolderLoading extends FolderState {}

class FolderLoaded extends FolderState {
  final List<Folder> folders;
  final String? successMessage;
  final Folder? currentFolder;

  const FolderLoaded(this.folders, {this.successMessage, this.currentFolder});

  @override
  List<Object?> get props => [folders, successMessage, currentFolder];
}

class FolderError extends FolderState {
  final String message;

  const FolderError(this.message);

  @override
  List<Object> get props => [message];
}

class FolderChanged extends FolderState {
  final Folder currentFolder;

  const FolderChanged(this.currentFolder);

  @override
  List<Object?> get props => [currentFolder];
}
