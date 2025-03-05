import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bar.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_drawer.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_navigation.dart';

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

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return TaskList(taskTab: index);
      case 1:
        return TaskList(taskTab: index);
      case 2:
        return TaskList(taskTab: index);
      default:
        return TaskList(taskTab: index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la key al Scaffold
      appBar: CustomAppBar(title: 'Todo List App', scaffoldKey: _scaffoldKey),
      drawer: CustomAppDrawer(
        screenIndex: screenIndex,
        handleScreenChanged: _onDestinationSelected,
      ),
      body: _getScreen(screenIndex),
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
