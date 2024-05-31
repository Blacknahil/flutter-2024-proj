import 'package:bloc_2/domain/folder/folder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Folder', () {
    test('should create a valid folder', () {
      final folder =
          Folder(id: '1', title: 'My Folder', notesIds: ['note1', 'note2']);

      expect(folder.id, '1');
      expect(folder.title, 'My Folder');
      expect(folder.notesIds, ['note1', 'note2']);
    });

    test('should create a folder from JSON', () {
      final json = {
        'id': '1',
        'title': 'My Folder',
        'noteIds': ['note1', 'note2']
      };

      final folder = Folder.fromJson(json);

      expect(folder.id, '1');
      expect(folder.title, 'My Folder');
      expect(folder.notesIds, ['note1', 'note2']);
    });
  });
}
