class Folder {
  final String id;
  final String title;
  final List<String> notesIds;

  Folder({required this.id, required this.title, required this.notesIds});

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'] ?? json['_id'],
      title: json['title'],
      notesIds: List<String>.from(json['noteIds']),
    );
  }
}
