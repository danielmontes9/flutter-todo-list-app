import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_date_picker.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_filled_button.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_area.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_field.dart';

class FormTaskPage extends StatefulWidget {
  final String title;

  const FormTaskPage({super.key, required this.title});

  @override
  State<FormTaskPage> createState() => _FormTaskPagePageState();
}

class _FormTaskPagePageState extends State<FormTaskPage> {
  void _saveTask() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            CustomTextField(label: 'Task Name'),
            SizedBox(height: 28),
            CustomDatePicker(label: 'Due Date'),
            SizedBox(height: 28),
            CustomTextArea(label: 'Description'),
            SizedBox(height: 28),
            CustomFilledButton(label: 'Save', onPressed: _saveTask),
          ],
        ),
      ),
    );
  }
}
