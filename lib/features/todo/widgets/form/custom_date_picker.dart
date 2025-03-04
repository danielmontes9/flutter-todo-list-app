import 'package:flutter/material.dart';

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
      // _controller.text = DateFormat.yMMMd().format(pickedDate);
      _controller.text = pickedDate.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
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
