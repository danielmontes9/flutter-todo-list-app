import 'package:flutter/widgets.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  final int taskTab;
  final List<Todo> todos;

  const TaskList({super.key, required this.taskTab, required this.todos});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskTile(
          title: widget.todos[index].title,
          subtitle: widget.todos[index].description,
          dueDate: widget.todos[index].dueDate,
          status: widget.todos[index].status,
        );
      },
    );
    // ListView.builder(
    //   itemCount: todos.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return TaskTile(
    //       title: 'Task $index',
    //       subtitle: 'Description of task $index',
    //       status:
    //           index % 3 == 0
    //               ? TodoStatus.pending
    //               : index % 3 == 1
    //               ? TodoStatus.completed
    //               : TodoStatus.archived,
    //     );
    //   },
    // );
  }
}
