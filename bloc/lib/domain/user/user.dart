import 'package:equatable/equatable.dart';

enum Role { user, admin }

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool banned;
  final List<String> folders;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.banned,
    required this.folders,
    required this.role,
  });

  static const empty = User(
    id: '',
    name: '',
    email: '',
    role: '',
    banned: false,
    folders: [],
  );
  @override
  List<Object> get props => [id, name, email, role, banned, folders];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      banned: json['banned'],
      folders: List<String>.from(json['foldersArray']),
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    bool? banned,
    List<String>? folders,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      banned: banned ?? this.banned,
      folders: folders ?? this.folders,
    );
  }
}
