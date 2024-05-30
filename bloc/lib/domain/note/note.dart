class Note {
  final String id;
  final String title;
  final String content;
  final String folderId;
  final String userId;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.folderId = '',
    this.userId = '',
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? folderId,
    String? userId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      folderId: folderId ?? this.folderId,
      userId: userId ?? this.userId,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] ?? json['_id'] ?? json['noteId'],
      title: json['title'],
      content: json['content'],
    );
  }
}
