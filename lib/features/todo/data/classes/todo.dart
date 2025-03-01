// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final Todostatus status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    Todostatus? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: Todostatus.values.firstWhere((element) =>  element.toString() ==  'Todostatus.${map['status']}'),
    );
  }

  String toJson() =>  json.encode(toMap());

  factory Todo.fromJson(String source) =>  Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, status: $status)';
  }

  @override
  bool operator ==  (covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id ==  id &&
      other.title ==  title &&
      other.description ==  description &&
      other.status ==  status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      status.hashCode;
  }
}
