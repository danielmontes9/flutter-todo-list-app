import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/report/card_status.dart';

class LayoutReport extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;

  const LayoutReport({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double percentageCompleted = (completedTasks / totalTasks);

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
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 28,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                    ),
                    Container(
                      height: 28,
                      width:
                          screenWidth *
                          percentageCompleted, // percentageCompleted progress
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.info,
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          "$percentageCompleted%",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CardStatus(type: 'pending', value: pendingTasks),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CardStatus(type: 'completed', value: completedTasks),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
