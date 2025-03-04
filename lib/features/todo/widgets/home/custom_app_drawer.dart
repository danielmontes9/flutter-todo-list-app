import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_bloc.dart';
import 'package:flutter_todo_list_app/core/blocs/theme/theme_event.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/core/theme/theme.dart';
import 'package:flutter_todo_list_app/features/todo/screens/home.dart';

class CustomAppDrawer extends StatelessWidget {
  final int screenIndex;
  final void Function(int) handleScreenChanged;

  const CustomAppDrawer({
    super.key,
    required this.screenIndex,
    required this.handleScreenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      backgroundColor: AppColors.backgroundLigth,
      indicatorColor: AppColors.primaryAccent,
      onDestinationSelected: handleScreenChanged,
      selectedIndex: screenIndex,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 0),
          child: Text(
            'Todo List App',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Seccions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...destinations.map((HomeTab destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
          );
        }),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value:
                  context.read<ThemeBloc>().state.themeData ==
                  AppTheme.darkTheme,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            ),
          ),
        ),
      ],
    );
  }
}
