import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/routing/home_tab.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class CustomAppNavigation extends StatelessWidget {
  final int screenIndex;
  final void Function(int) onDestinationSelected;

  const CustomAppNavigation({
    super.key,
    required this.screenIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: screenIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: AppColors.primary,
      indicatorColor: AppColors.primaryAccent,
      destinations:
          navigationRouter.map((HomeTab destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          }).toList(),
    );
  }
}
