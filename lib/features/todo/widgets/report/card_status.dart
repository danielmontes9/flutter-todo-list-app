import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class CardStatus extends StatelessWidget {
  final String type;
  final int value;

  const CardStatus({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type == "pending" ? AppColors.warningDark : AppColors.success,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Card(
        color: type == "pending" ? AppColors.warning : AppColors.success,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {},
          splashColor:
              type == "pending" ? AppColors.warningLight : AppColors.success,
          radius: 20,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.pending_actions, size: 72, color: AppColors.white),
                const SizedBox(height: 10),
                Text(
                  "$value",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  type == "pending" ? "Pending" : "Completed",
                  style: TextStyle(fontSize: 24, color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
