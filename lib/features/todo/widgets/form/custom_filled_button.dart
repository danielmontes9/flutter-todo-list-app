import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CustomFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: Text(label),
    );
  }
}
