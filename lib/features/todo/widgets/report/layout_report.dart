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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Progress of the month',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    minHeight: 24,
                    borderRadius: BorderRadius.circular(12),
                    value: 20,
                    semanticsLabel: 'Linear progress indicator',
                  ),
                ),
                SizedBox(width: 10),
                Text('20%', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 20),
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
