import 'package:flutter/material.dart';

class TaskListNotFound extends StatelessWidget {
  const TaskListNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sticky_note_2_outlined, size: 100),
          SizedBox(height: 16),
          const Text('No tasks found', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
