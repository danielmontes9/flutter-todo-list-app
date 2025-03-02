import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_tile.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FormTaskPage(title: 'Add Task'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          TaskTile(
            title: 'Task 1',
            subtitle: 'Description 1',
            status: Todostatus.pending,
          ),
          Divider(
            indent: screenWidth * 0.05,
            endIndent: screenWidth * 0.05,
            color: AppColors.disabled,
          ),
          TaskTile(
            title: 'Task 2',
            subtitle: 'Description 2',
            status: Todostatus.inProgress,
          ),
          Divider(
            indent: screenWidth * 0.05,
            endIndent: screenWidth * 0.05,
            color: AppColors.disabled,
          ),
          TaskTile(
            title: 'Task 3',
            subtitle: 'Description 3',
            status: Todostatus.completed,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _DemoBottomAppBar(
        fabLocation: FloatingActionButtonLocation.endDocked,
        shape: null,
      ),
    );
  }
}

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
        FloatingActionButtonLocation.centerDocked,
        FloatingActionButtonLocation.centerFloat,
      ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: AppColors.primary,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu, color: AppColors.white),
              onPressed: () {},
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Pending Tasks',
              icon: const Icon(Icons.pending_actions, color: AppColors.white),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'In Process',
              icon: const Icon(Icons.pending_outlined, color: AppColors.white),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Done Tasks',
              icon: const Icon(Icons.task_alt, color: AppColors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
