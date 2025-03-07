import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final TodoStatus status;

  const TaskTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      leading:
          (
          // widget.leading
          widget.status == TodoStatus.pending
              ? const Icon(Icons.pending_actions, color: AppColors.warning)
              : widget.status == TodoStatus.archived
              ? const Icon(Icons.pending_outlined, color: AppColors.info)
              : const Icon(Icons.task_alt, color: AppColors.success)),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            const PopupMenuItem(child: Text('Edit')),
            const PopupMenuItem(child: Text('Delete')),
            const PopupMenuItem(child: Text('Mark as completed')),
          ];
        },
      ),
    );
  }
}
