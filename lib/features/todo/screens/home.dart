import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bar.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_drawer.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_navigation.dart';

class HomeTab {
  const HomeTab(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<HomeTab> destinations = <HomeTab>[
  HomeTab(
    'All',
    Icon(Icons.widgets_outlined, color: AppColors.black),
    Icon(Icons.widgets, color: AppColors.black),
  ),
  HomeTab(
    'Pending Tasks',
    Icon(Icons.pending_actions_outlined, color: AppColors.black),
    Icon(Icons.pending_actions, color: AppColors.black),
  ),
  HomeTab(
    'Completed Tasks',
    Icon(Icons.task_alt_outlined, color: AppColors.black),
    Icon(Icons.task_alt, color: AppColors.black),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void _goToAddTaskScreen() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FormTaskPage(title: 'Add Task'),
        ),
      );
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la key al Scaffold
      appBar: CustomAppBar(title: 'Todo List App', scaffoldKey: _scaffoldKey),
      drawer: CustomAppDrawer(),
      body: TaskList(taskTab: screenIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: _goToAddTaskScreen,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomAppNavigation(
        screenIndex: screenIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final int taskTab;

  const TaskList({super.key, required this.taskTab});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Text('Page Index = ${widget.taskTab}')],
      ),
    );
    // ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) {
    //     return TaskTile(
    //       title: 'Task $index',
    //       subtitle: 'Description of task $index',
    //       status:
    //           index % 3 == 0
    //               ? Todostatus.pending
    //               : index % 3 == 1
    //               ? Todostatus.inProgress
    //               : Todostatus.completed,
    //     );
    //   },
    // );
  }
}
