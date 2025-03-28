import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_event.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_state.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_date_picker.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_filled_button.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_area.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/form/custom_text_field.dart';

class FormTaskPage extends StatefulWidget {
  final String title;
  final int? id;

  const FormTaskPage({super.key, required this.title, this.id});

  @override
  State<FormTaskPage> createState() => _FormTaskPagePageState();
}

class _FormTaskPagePageState extends State<FormTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDueDateController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  void _saveTask() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    context.read<TaskBloc>().add(
      AddTaskEvent(
        title: _taskNameController.text,
        dueDate: _taskDueDateController.text,
        description: _taskDescriptionController.text,
        status: TodoStatus.pending.name,
      ),
    );
    Navigator.pop(context);
  }

  _updateTask() {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    context.read<TaskBloc>().add(
      UpdateTaskEvent(
        id: widget.id!,
        title: _taskNameController.text,
        dueDate: _taskDueDateController.text,
        description: _taskDescriptionController.text,
        status: TodoStatus.pending.name,
      ),
    );

    Navigator.pop(context);
  }

  void _loadTaskData(int id) {
    context.read<TaskBloc>().add(GetTaskByIdEvent(id: id));
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // Load the task data if an ID is provided
      _loadTaskData(widget.id!);
    }
  }

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
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskById) {
            if (state.todo.id != null) {
              _taskNameController.text = state.todo.title;
              _taskDueDateController.text = state.todo.dueDate;
              _taskDescriptionController.text = state.todo.description;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomTextField(
                    label: 'Task Name',
                    controller: _taskNameController,
                  ),
                  SizedBox(height: 28),
                  CustomDatePicker(
                    label: 'Due Date',
                    controller: _taskDueDateController,
                  ),
                  SizedBox(height: 28),
                  CustomTextArea(
                    label: 'Description',
                    controller: _taskDescriptionController,
                  ),
                  SizedBox(height: 28),
                  widget.id == null
                      ? CustomFilledButton(label: 'Save', onPressed: _saveTask)
                      : CustomFilledButton(
                        label: 'Update',
                        onPressed: _updateTask,
                      ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
