// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  final String status;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    String? dueDate,
    String? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'status': status,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? 0,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: map['dueDate'] ?? '',
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, dueDate: $dueDate, status: $status)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.dueDate == dueDate &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dueDate.hashCode ^
        status.hashCode;
  }
}
