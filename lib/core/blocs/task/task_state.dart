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
  final String id;

  TaskArchivedState({required this.id});

  @override
  List<Object> get props => [id];
}
