import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String dueDate;
  final String status;

  const TaskTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dueDate,
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
              : const Icon(Icons.task_alt, size: 36, color: AppColors.success)),
      trailing: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            const PopupMenuItem(
              child: Row(
                spacing: 8,
                children: [Icon(Icons.edit), Text('Edit')],
              ),
            ),
            const PopupMenuItem(
              child: Row(
                spacing: 8,
                children: [Icon(Icons.archive_outlined), Text('Archive')],
              ),
            ),
            const PopupMenuItem(
              child: Row(
                spacing: 8,
                children: [Icon(Icons.delete), Text('Delete')],
              ),
            ),
            const PopupMenuItem(
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
  }
}
