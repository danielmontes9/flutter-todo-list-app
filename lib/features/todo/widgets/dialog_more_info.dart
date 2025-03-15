import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/icon_status.dart';

class DialogMoreInfo extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;
  final String status;

  const DialogMoreInfo({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("TASK"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: IconStatus(status: status)),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Due Date:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(dueDate, style: TextStyle(fontSize: 16))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(status.toUpperCase(), style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Title:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(description, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
