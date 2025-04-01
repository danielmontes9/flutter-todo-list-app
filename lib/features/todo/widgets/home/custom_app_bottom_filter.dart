import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_filters.dart';

class CustomAppBottomFilter extends StatefulWidget {
  const CustomAppBottomFilter({super.key});

  @override
  State<CustomAppBottomFilter> createState() => CustomAppBottomFilterState();
}

class CustomAppBottomFilterState extends State<CustomAppBottomFilter> {
  int selectedIndex = 0;

  FiltersByTasks? _character = FiltersByTasks.name;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
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
                        'Filter data by:',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(indent: 24, endIndent: 24, color: AppColors.disabled),
                  ListTile(
                    title: const Text('Name', style: TextStyle(fontSize: 16)),
                    leading: Radio<FiltersByTasks>(
                      value: FiltersByTasks.name,
                      groupValue: _character,
                      onChanged: (value) {
                        setModalState(() {
                          _character = value!;
                        });
                        setState(() {
                          _character = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Date', style: TextStyle(fontSize: 16)),
                    leading: Radio<FiltersByTasks>(
                      value: FiltersByTasks.date,
                      groupValue: _character,
                      onChanged: (value) {
                        setModalState(() {
                          _character = value!;
                        });
                        setState(() {
                          _character = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
