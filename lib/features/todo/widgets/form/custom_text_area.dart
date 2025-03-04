import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String label;

  const CustomTextArea({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 120,
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
