import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/dialog_confirm.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/dialog_more_info.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/icon_status.dart';

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
  void _editTask(int idSelected) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormTaskPage(title: 'Edit Task', id: idSelected),
      ),
    );
    return;
  }

  void _archieveTask(int id) {
    context.read<TaskBloc>().add(
      ArchiveTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'archived',
      ),
    );
  }

  void _unarchieveTask(int id) {
    context.read<TaskBloc>().add(
      UnarchiveTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'pending',
      ),
    );
  }

  void _deleteTask(int id) {
    context.read<TaskBloc>().add(DeleteTaskEvent(id: id.toString()));
  }

  void _markAsCompleted(int id) {
    context.read<TaskBloc>().add(
      MarkAsCompletedTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'completed',
      ),
    );
  }

  void _markAsUncompleted(int id) {
    context.read<TaskBloc>().add(
      MarkAsUncompletedTaskEvent(
        id: id,
        title: widget.title,
        description: widget.subtitle,
        dueDate: widget.dueDate,
        status: 'pending',
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogMoreInfo(
          title: widget.title,
          description: widget.subtitle,
          dueDate: widget.dueDate,
          status: widget.status,
        );
      },
    );
  }

  Future<void> _dialogDeleteBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirm(
          title: 'Delete Task',
          description: 'Are you sure you want to delete this task?',
          onConfirm: () => _deleteTask(widget.id),
        );
      },
    );
  }

  Future<void> _dialogArchieveBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirm(
          title: 'Archieve Task',
          description: 'Are you sure you want to archieve this task?',
          onConfirm: () => _archieveTask(widget.id),
        );
      },
    );
  }

  Future<void> _dialogUnarchieveBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogConfirm(
          title: 'Unarchieve Task',
          description: 'Are you sure you want to unarchieve this task?',
          onConfirm: () => _unarchieveTask(widget.id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, snapshot) {
        return ListTile(
          onLongPress: () => _dialogBuilder(context),
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dueDate,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(widget.subtitle),
            ],
          ),
          leading: IconStatus(status: widget.status),
          trailing: PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                // CustomTaskTileMenuItem(
                //   functionOnTap: _editTask(widget.id),
                //   icon: Icon(Icons.edit),
                //   label: Text('Edit'),
                // ),
                PopupMenuItem(
                  onTap: () => _editTask(widget.id),
                  child: Row(
                    spacing: 8,
                    children: [Icon(Icons.edit), Text('Edit')],
                  ),
                ),

                widget.status == 'archived'
                    ? PopupMenuItem(
                      onTap: () => _dialogUnarchieveBuilder(context),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.unarchive_outlined),
                          Text('Unarchive'),
                        ],
                      ),
                    )
                    : PopupMenuItem(
                      onTap: () => _dialogArchieveBuilder(context),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.archive_outlined),
                          Text('Archive'),
                        ],
                      ),
                    ),

                PopupMenuItem(
                  onTap: () => _dialogDeleteBuilder(context),
                  child: Row(
                    spacing: 8,
                    children: [Icon(Icons.delete), Text('Delete')],
                  ),
                ),

                widget.status == 'completed'
                    ? PopupMenuItem(
                      onTap: () => _markAsUncompleted(widget.id),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.pending_actions_outlined),
                          Text('Mark as uncompleted'),
                        ],
                      ),
                    )
                    : PopupMenuItem(
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

class CustomTaskTileMenuItem extends StatelessWidget {
  final void Function() functionOnTap;
  final Icon icon;
  final Text label;

  const CustomTaskTileMenuItem({
    super.key,
    required this.functionOnTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<dynamic>(
      onTap: functionOnTap,
      child: Row(spacing: 8, children: [icon, label]),
    );
  }
}
