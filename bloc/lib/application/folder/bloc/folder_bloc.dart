import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/folder/folder.dart';
import '../../../domain/folder/folder_repository.dart';
import 'dart:developer' as devtools;

part 'folder_event.dart';
part 'folder_state.dart';

class FoldersBloc extends Bloc<FolderEvent, FolderState> {
  final FoldersRepository foldersrepository;

  FoldersBloc(this.foldersrepository) : super(FolderInitial()) {
    on<FetchFolders>(_onFetchFolders);
    on<CreateFolder>(_onCreateFolder);
    on<ChangeCurrentFolder>(_onChangeCurrentFolder);
  }

  Future<void> _onFetchFolders(
      FetchFolders event, Emitter<FolderState> emit) async {
    emit(FolderLoading());
    devtools.log("trying to fetch folders");
    final result =
        await foldersrepository.getFolders(event.userId, event.token);
    devtools.log("result for fetching folder is $result");
    result.fold(
      (failure) => emit(FolderError(failure.message)),
      (folders) => emit(FolderLoaded(folders)),
    );
  }

  Future<void> _onCreateFolder(
      CreateFolder event, Emitter<FolderState> emit) async {
    final currentState = state;
    devtools.log("current state is $currentState");
    if (currentState is FolderLoaded) {
      emit(FolderLoading());
      final result = await foldersrepository.createFolder(
          event.title, event.userId, event.token);
      devtools.log('result is $result');
      result.fold(
        (failure) => emit(FolderError(failure.message)),
        (folder) {
          final updatedFolders = List<Folder>.from(currentState.folders)
            ..add(folder);
          emit(FolderLoaded(updatedFolders,
              successMessage: "Folder created successfully"));
        },
      );
    }
  }

  Future<void> _onChangeCurrentFolder(
      ChangeCurrentFolder event, Emitter<FolderState> emit) async {
    devtools
        .log("trying to fetch folder details for folderId: ${event.folderId}");
    final result =
        await foldersrepository.getOneFolder(event.folderId, event.token);
    devtools.log("result for fetching folder details is $result");
    result.fold(
      (failure) => {
        devtools.log(failure as String),
        emit(
          FolderError(failure.message),
        )
      },
      (folder) {
        final currentState = state;

        if (currentState is FolderLoaded) {
          emit(FolderLoaded(currentState.folders, currentFolder: folder));
          final curr = currentState.currentFolder;
          print("current folder is $curr");
        }
      },
    );
  }
}
