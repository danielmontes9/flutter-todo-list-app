

import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Task 1'),
            subtitle: const Text('Description of Task 1'),
            leading: const Icon(Icons.pending_actions),
            trailing: PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  print(value);
                });
              },
              itemBuilder: (BuildContext context) =>  <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    spacing: 10,
                    children: <Widget>[
                      Icon(Icons.edit),
                      Text('Edit'),
                    ],  
                  )
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    spacing: 10,
                    children: <Widget>[
                      Icon(Icons.delete),
                      Text('Delete'),
                    ],  
                  )
                ),
              ],
            )
          ),
          Divider(),
          ListTile(
            title: const Text('Task 2'),
            subtitle: const Text('Description of Task 2'),
            leading: const Icon(Icons.pending_outlined),
          ),
          Divider(),
          ListTile(
            title: const Text('Task 3'),
            subtitle: const Text('Description of Task 3'),
            leading: const Icon(Icons.task_alt),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _DemoBottomAppBar(
          fabLocation: FloatingActionButtonLocation.endDocked,
          shape: null,
      ),
    );
  }
}


class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: AppColors.secondary,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(tooltip: 'Open navigation menu', icon: const Icon(Icons.menu, color: AppColors.black,), onPressed: () {},),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(tooltip: 'Pending Tasks', icon: const Icon(Icons.pending_actions, color: AppColors.black), onPressed: () {}),
            IconButton(tooltip: 'In Process', icon: const Icon(Icons.pending_outlined, color: AppColors.black), onPressed: () {}),
            IconButton(tooltip: 'Done Tasks', icon: const Icon(Icons.task_alt, color: AppColors.black), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
