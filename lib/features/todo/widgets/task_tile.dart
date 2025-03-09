import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';

class TaskTile extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final String dueDate;
  final String status;

  const TaskTile({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dueDate,
    required this.status,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  void _editTask(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FormTaskPage(title: 'Edit Task')),
    );
    return;
  }

  void _archieveTask(int id) {
    context.read<TaskBloc>().add(
      UpdateTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'archived',
      ),
    );
  }

  void _deleteTask(int id) {
    context.read<TaskBloc>().add(DeleteTaskEvent(id: id.toString()));
  }

  void _markAsCompleted(int id) {
    context.read<TaskBloc>().add(
      UpdateTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'completed',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, snapshot) {
        return ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          leading:
              (widget.status == 'pending'
                  ? const Icon(
                    Icons.pending_actions,
                    size: 36,
                    color: AppColors.warning,
                  )
                  : widget.status == 'archived'
                  ? const Icon(
                    Icons.pending_outlined,
                    size: 36,
                    color: AppColors.info,
                  )
                  : const Icon(
                    Icons.task_alt,
                    size: 36,
                    color: AppColors.success,
                  )),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () => _editTask(widget.id),
                  child: Row(
                    spacing: 8,
                    children: [Icon(Icons.edit), Text('Edit')],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _archieveTask(widget.id),
                  child: Row(
                    spacing: 8,
                    children: [Icon(Icons.archive_outlined), Text('Archive')],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _deleteTask(widget.id),
                  child: Row(
                    spacing: 8,
                    children: [Icon(Icons.delete), Text('Delete')],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => _markAsCompleted(widget.id),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.done_all_outlined),
                      Text('Mark as completed'),
                    ],
                  ),
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
