import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_helper.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitialState()) {
    on<LoadTasksEvent>(_onLoadingTasks);
    on<GetTasksEvent>(_onGetTasks);
    on<AddTaskEvent>(_onTaskAdded);
    on<UpdateTaskEvent>(_onTaskUpdated);
    on<DeleteTaskEvent>(_onTaskDeleted);
    on<ArchiveTaskEvent>(_onTaskArchived);
  }

  _onLoadingTasks(LoadTasksEvent event, Emitter<TaskState> emit) {
    emit(TaskLoadingState());
  }

  _onGetTasks(GetTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());
    emit(TaskLoadedState(todos: []));
    final tasks = await DatabaseHelper().getTasks(event.status);
    print(tasks);
    emit(TaskLoadedState(todos: tasks));
  }

  _onTaskAdded(AddTaskEvent event, Emitter<TaskState> emit) {
    Todo newTask = Todo(
      title: event.title,
      description: event.description,
      dueDate: event.dueDate,
      status: event.status,
    );
    print(newTask);
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
    emit(TaskUpdatedState(todo: updatedTask));
  }

  _onTaskDeleted(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskDeletedState(id: event.id));
  }

  _onTaskArchived(ArchiveTaskEvent event, Emitter<TaskState> emit) {
    emit(TaskArchivedState(id: event.id));
  }
}
