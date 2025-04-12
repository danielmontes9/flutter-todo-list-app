import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class CustomAppBottomFilter extends StatefulWidget {
  final int screenIndex;

  const CustomAppBottomFilter({super.key, required this.screenIndex});

  @override
  State<CustomAppBottomFilter> createState() => CustomAppBottomFilterState();
}

class CustomAppBottomFilterState extends State<CustomAppBottomFilter> {
  int selectedIndex = 0;

  IconData? _iconArrowName;
  IconData? _iconArrowDate;

  void updateSortingName() {
    setState(() {
      _iconArrowDate = null;
      _iconArrowName =
          _iconArrowName == Icons.arrow_upward
              ? Icons.arrow_downward
              : Icons.arrow_upward;

      String orderBy =
          _iconArrowName == Icons.arrow_upward ? 'title ASC' : 'title DESC';
      context.read<TaskBloc>().add(
        GetTasksEvent(
          status: getStatusSelectedByIndex(widget.screenIndex),
          orderBy: orderBy,
        ),
      );
    });
  }

  void updateSortingDate() {
    setState(() {
      _iconArrowName = null;
      _iconArrowDate =
          _iconArrowDate == Icons.arrow_upward
              ? Icons.arrow_downward
              : Icons.arrow_upward;

      String orderBy =
          _iconArrowDate == Icons.arrow_upward
              ? 'due_date ASC'
              : 'due_date DESC';
      context.read<TaskBloc>().add(
        GetTasksEvent(
          status: getStatusSelectedByIndex(widget.screenIndex),
          orderBy: orderBy,
        ),
      );
    });
  }

  String getStatusSelectedByIndex(int index) {
    switch (index) {
      case 0:
        return 'pending';
      case 1:
        return 'completed';
      case 2:
        return 'archived';
      default:
        return 'all';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: StatefulBuilder(
        builder:
            (BuildContext context, StateSetter setModalState) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24,
                        bottom: 12,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sort data by:',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      indent: 24,
                      endIndent: 24,
                      color: AppColors.disabled,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Name', style: TextStyle(fontSize: 16)),
                      trailing: Icon(_iconArrowName),
                      onTap: updateSortingName,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Date', style: TextStyle(fontSize: 16)),
                      trailing: Icon(_iconArrowDate),
                      onTap: updateSortingDate,
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
