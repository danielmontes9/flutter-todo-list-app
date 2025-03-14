import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class IconStatus extends StatelessWidget {
  final String status;
  const IconStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            status == 'pending'
                ? AppColors.warning
                : status == 'archived'
                ? AppColors.info
                : AppColors.success,
      ),
      child: Icon(
        status == 'pending'
            ? Icons.pending_actions
            : status == 'archived'
            ? Icons.pending_outlined
            : Icons.check_circle_outline,
        size: 36,
        color: AppColors.white,
      ),
    );
  }
}
