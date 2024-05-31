import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_2/domain/folder/folder_repository.dart';
import 'package:bloc_2/application/folder/bloc/folder_bloc.dart';

class MockFoldersRepository extends Mock implements FoldersRepository {}

void main() {
  group('FoldersBloc', () {
    late FoldersRepository repository;
    late FoldersBloc foldersBloc;

    setUp(() {
      repository = MockFoldersRepository();
      foldersBloc = FoldersBloc(repository);
    });

    tearDown(() {
      foldersBloc.close();
    });

    test('initial state is correct', () {
      expect(foldersBloc.state, FolderInitial());
    });
  });
}
