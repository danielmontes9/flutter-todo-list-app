import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/report/card_status.dart';

class LayoutReport extends StatelessWidget {
  const LayoutReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Status of my Tasks',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(children: []),
            Row(
              children: [
                Expanded(child: CardStatus(type: 'pending', value: 0)),
                SizedBox(width: 10),
                Expanded(child: CardStatus(type: 'completed', value: 0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
