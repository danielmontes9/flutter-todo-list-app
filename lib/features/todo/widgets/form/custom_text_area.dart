import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextArea({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: TextField(
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
