import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_helper.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitialState()) {
    on<LoadTasksEvent>(_onLoadingTasks);
    on<GetTasksEvent>(_onGetTasks);
    on<GetTaskByIdEvent>(_onGetTaskById);
    on<AddTaskEvent>(_onTaskAdded);
    on<UpdateTaskEvent>(_onTaskUpdated);
    on<DeleteTaskEvent>(_onTaskDeleted);
    on<ArchiveTaskEvent>(_onTaskArchived);
    on<UnarchiveTaskEvent>(_onTaskUnarchived);
    on<MarkAsCompletedTaskEvent>(_onTaskCompleted);
    on<MarkAsUncompletedTaskEvent>(_onTaskUncompleted);
  }

  _onLoadingTasks(LoadTasksEvent event, Emitter<TaskState> emit) {
    emit(TaskLoadingState());
  }

  _onGetTasks(GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    emit(TaskLoadedState(todos: []));
    final tasks = await DatabaseHelper().getTasks(event.status, event.orderBy);
    emit(TaskLoadedState(todos: tasks));
  }

  _onGetTaskById(GetTaskByIdEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    final Todo? task = await DatabaseHelper().getTaskById(event.id);
    emit(TaskById(todo: task as Todo));
  }

  _onTaskAdded(AddTaskEvent event, Emitter<TaskState> emit) {
    Todo newTask = Todo(
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );
    DatabaseHelper().insertTask(newTask);
    emit(TaskAddedState(todo: newTask));
  }

  _onTaskUpdated(UpdateTaskEvent event, Emitter<TaskState> emit) {
    final updatedTask = Todo(
      id: event.id,
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );
    DatabaseHelper().updateTask(updatedTask);
    emit(TaskUpdatedState(todo: updatedTask));
  }

  _onTaskDeleted(DeleteTaskEvent event, Emitter<TaskState> emit) {
    DatabaseHelper().deleteTask(event.id);
    emit(TaskDeletedState(id: event.id));
  }

  _onTaskArchived(ArchiveTaskEvent event, Emitter<TaskState> emit) {
    final archivedTask = Todo(
      id: event.id,
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );

    DatabaseHelper().updateTask(archivedTask);

    emit(TaskArchivedState(todo: archivedTask));
  }

  _onTaskUnarchived(UnarchiveTaskEvent event, Emitter<TaskState> emit) {
    final unarchivedTask = Todo(
      id: event.id,
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );

    DatabaseHelper().updateTask(unarchivedTask);

    emit(TaskUnarchivedState(todo: unarchivedTask));
  }

  _onTaskCompleted(MarkAsCompletedTaskEvent event, Emitter<TaskState> emit) {
    final completedTask = Todo(
      id: event.id,
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );

    DatabaseHelper().updateTask(completedTask);

    emit(TaskCompletedState(todo: completedTask));
  }

  _onTaskUncompleted(
    MarkAsUncompletedTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    final uncompletedTask = Todo(
      id: event.id,
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );

    DatabaseHelper().updateTask(uncompletedTask);

    emit(TaskUncompletedState(todo: uncompletedTask));
  }
}
