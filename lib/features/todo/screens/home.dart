import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_helper.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bar.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_drawer.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_navigation.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_list.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_list_not_found.dart';
import 'package:logger/web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var logger = Logger();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _fetchTasks(0);
  }

  Future<void> _initDatabase() async {
    await DatabaseHelper().database;
  }

  void _fetchTasks(int index) {
    String statusSelected = 'all';

    switch (index) {
      case 0:
        statusSelected = 'pending';
        break;
      case 1:
        statusSelected = 'completed';
        break;
      case 2:
        statusSelected = 'archived';
        break;
      default:
        statusSelected = 'all';
        break;
    }

    context.read<TaskBloc>().add(GetTasksEvent(status: statusSelected));
  }

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

      _fetchTasks(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: 'Todo List App', scaffoldKey: _scaffoldKey),
      drawer: CustomAppDrawer(
        screenIndex: screenIndex,
        handleScreenChanged: _onDestinationSelected,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadedState) {
            return state.todos.isEmpty
                ? TaskListNotFound()
                : TaskList(taskTab: screenIndex, todos: state.todos);
          }

          if (state is TaskAddedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskDeletedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskArchivedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskCompletedState) {
            _fetchTasks(screenIndex);
          }

          return TaskListNotFound();
        },
      ),
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
