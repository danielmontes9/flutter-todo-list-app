import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_helper.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/data/classes/todo.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bar.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_drawer.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_navigation.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _fetchTasks('pending');
  }

  Future<void> _initDatabase() async {
    await DatabaseHelper().database;
  }

  void _fetchTasks(String statusSelected) {
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

      switch (index) {
        case 0:
          _fetchTasks('pending');
          break;
        case 1:
          _fetchTasks('completed');
          break;
        case 2:
          _fetchTasks('archived');
          break;
        default:
          _fetchTasks('all');
          break;
      }
    });
  }

  Widget _getScreen(int index, List<Todo> todos) {
    print(index);
    switch (index) {
      case 0:
        return TaskList(taskTab: index, todos: todos);
      case 1:
        return TaskList(taskTab: index, todos: todos);
      case 2:
        return TaskList(taskTab: index, todos: todos);
      default:
        _fetchTasks('all');
        return TaskList(taskTab: index, todos: todos);
    }
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
          print(state);

          if (state is TaskInitialState) {
            // _getScreen(screenIndex, List<Todo>.empty());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskLoadedState) {
            return state.todos.isEmpty
                ? Center(child: const Text('No tasks found'))
                : TaskList(taskTab: screenIndex, todos: state.todos);
          }

          return const Center(child: CircularProgressIndicator());
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
