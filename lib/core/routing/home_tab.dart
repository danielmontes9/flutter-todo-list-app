import 'package:flutter/material.dart';

class HomeTab {
  const HomeTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<HomeTab> drawerRouter = <HomeTab>[
  HomeTab(
    'Pending Tasks',
    Icon(Icons.pending_actions_outlined),
    Icon(Icons.pending_actions),
  ),

  HomeTab(
    'Completed Tasks',
    Icon(Icons.task_alt_outlined),
    Icon(Icons.task_alt),
  ),
  HomeTab('Archived', Icon(Icons.archive_outlined), Icon(Icons.archive)),
  HomeTab('All', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
];

const List<HomeTab> navigationRouter = <HomeTab>[
  HomeTab(
    'Pending Tasks',
    Icon(Icons.pending_actions_outlined),
    Icon(Icons.pending_actions),
  ),
  HomeTab(
    'Completed Tasks',
    Icon(Icons.task_alt_outlined),
    Icon(Icons.task_alt),
  ),
];
