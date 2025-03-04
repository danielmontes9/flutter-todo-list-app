import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_area.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_field.dart';

class FormTaskPage extends StatefulWidget {
  final String title;

  const FormTaskPage({super.key, required this.title});

  @override
  State<FormTaskPage> createState() => _FormTaskPagePageState();
}

class _FormTaskPagePageState extends State<FormTaskPage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(label: 'Task Name'),
            CustomTextArea(label: 'Description'),
          ],
        ),
      ),
    );
  }
}
