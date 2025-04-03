import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/helpers/database_config_helper.dart';
import 'package:flutter_todo_list_app/core/helpers/database_helper.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bar.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_bottom_filter.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_drawer.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/home/custom_app_navigation.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/report/layout_report.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_list.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_list_not_found.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
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
    _initConfig();
    _fetchTasks(0);
  }

  Future<void> _initDatabase() async {
    await DatabaseHelper().database;
  }

  Future<void> _initConfig() async {
    await DatabaseConfigHelper().database;
  }

  void _fetchTasks(int index) {
    String statusSelected = 'all';

    print(index);

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
      case 3:
        statusSelected = 'all';
        break;
      case 4:
        statusSelected = 'report';
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
            if (screenIndex == 4) {
              return LayoutReport();
            }

            return state.todos.isEmpty
                ? TaskListNotFound()
                : Column(
                  children: [
                    TaskList(taskTab: screenIndex, todos: state.todos),
                  ],
                );
          }

          if (state is TaskById) {
            _fetchTasks(screenIndex);
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

          if (state is TaskUnarchivedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskUpdatedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskCompletedState) {
            _fetchTasks(screenIndex);
          }

          if (state is TaskUncompletedState) {
            _fetchTasks(screenIndex);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton:
          screenIndex == 0 || screenIndex == 1
              ? ExpandableFab(
                pos: ExpandableFabPos.center,
                type: ExpandableFabType.up,
                overlayStyle: ExpandableFabOverlayStyle(blur: 1.5),
                distance: 70,
                margin: const EdgeInsets.only(bottom: -48),
                openButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.add),
                  fabSize: ExpandableFabSize.regular,
                  backgroundColor: AppColors.secondary,
                  shape: const CircleBorder(),
                ),
                closeButtonBuilder: RotateFloatingActionButtonBuilder(
                  child: const Icon(Icons.close),
                  fabSize: ExpandableFabSize.regular,
                  backgroundColor: AppColors.secondary,
                  shape: const CircleBorder(),
                ),
                children: [
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: _goToAddTaskScreen,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add_circle),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => CustomAppBottomFilter(),
                      );
                    },

                    shape: const CircleBorder(),
                    child: const Icon(Icons.filter_alt),
                  ),
                ],
              )
              : null,
      bottomNavigationBar: CustomAppNavigation(
        screenIndex: screenIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
