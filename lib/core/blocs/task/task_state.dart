import 'package:equatable/equatable.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

//* Initial state of the TaskBloc
class TaskInitialState extends TaskState {}

//* State when a task is loading
class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Todo> todos;

  TaskLoadedState({required this.todos});

  @override
  List<Object> get props => [todos];
}

//* State when a task is added
class TaskAddedState extends TaskState {
  final Todo todo;

  TaskAddedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

//* State when a task is updated
class TaskUpdatedState extends TaskState {
  final Todo todo;

  TaskUpdatedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

//* State when a task is deleted
class TaskDeletedState extends TaskState {
  final String id;

  TaskDeletedState({required this.id});

  @override
  List<Object> get props => [id];
}

//* State when a task is archived
class TaskArchivedState extends TaskState {
  final Todo todo;

  TaskArchivedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

//* State when a task is unarchived
class TaskUnarchivedState extends TaskState {
  final Todo todo;

  TaskUnarchivedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

//* State when a task is marked as completed
class TaskCompletedState extends TaskState {
  final Todo todo;

  TaskCompletedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

//* State when a task is marked as uncompleted
class TaskUncompletedState extends TaskState {
  final Todo todo;

  TaskUncompletedState({required this.todo});

  @override
  List<Object> get props => [todo];
}
