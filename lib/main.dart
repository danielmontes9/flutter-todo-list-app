import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/task/task_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_state.dart';
import 'package:flutter_todo_list_app/features/todo/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeBloc = await ThemeBloc.create();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeBloc),
        BlocProvider(create: (_) => TaskBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Todo List App',
          theme: state.themeData,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}
