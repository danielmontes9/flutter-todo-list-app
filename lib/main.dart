import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/theme.dart';
import 'package:flutter_todo_list_app/features/todo/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Todo List App'),
    );
  }
}
