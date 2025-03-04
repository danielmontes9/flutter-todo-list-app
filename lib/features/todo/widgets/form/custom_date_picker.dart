import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;

  const CustomDatePicker({super.key, required this.label});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();

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

      _controller.text = DateFormat.yMMMd().format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        onTap: _selectDate,
        controller: _controller,
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
