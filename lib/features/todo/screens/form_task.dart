import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/custom_text_field.dart';

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
        backgroundColor: AppColors.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(label: 'Task Name'),
            CustomTextField(label: 'Description'),
          ],
        ),
      ),
    );
  }
}
