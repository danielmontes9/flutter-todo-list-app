import 'package:equatable/equatable.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String dueDate;
  final Todostatus status;

  const AddTaskEvent({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  List<Object> get props => [title, description, dueDate];
}

class UpdateTaskEvent extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String dueDate;

  const UpdateTaskEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object> get props => [id, title, description, dueDate];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ArchiveTaskEvent extends TaskEvent {
  final String id;

  const ArchiveTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
