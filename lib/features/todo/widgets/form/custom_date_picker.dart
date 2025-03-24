import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;

      if (pickedDate == null) return;

      widget.controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        onTap: _selectDate,
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.label,
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
