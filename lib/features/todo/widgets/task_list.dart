import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
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
        return Column(
          children: [
            TaskTile(
              title: widget.todos[index].title,
              subtitle: widget.todos[index].description,
              dueDate: widget.todos[index].dueDate,
              status: widget.todos[index].status,
            ),
            widget.todos.length != (index + 1)
                ? Divider(indent: 24, endIndent: 24, color: AppColors.disabled)
                : SizedBox(),
          ],
        );
      },
    );
  }
}
