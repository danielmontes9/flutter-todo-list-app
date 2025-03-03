import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';
import 'package:flutter_todo_list_app/features/todo/screens/form_task.dart';
import 'package:flutter_todo_list_app/features/todo/widgets/task_tile.dart';
import 'package:flutter_todo_list_app/features/todo/data/enums/todo_status.dart';

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
    'All',
    Icon(Icons.widgets_outlined, color: AppColors.black),
    Icon(Icons.widgets, color: AppColors.black),
  ),
  ExampleDestination(
    'Pending Tasks',
    Icon(Icons.pending_actions_outlined, color: AppColors.black),
    Icon(Icons.pending_actions, color: AppColors.black),
  ),
  ExampleDestination(
    'Completed Tasks',
    Icon(Icons.task_alt_outlined, color: AppColors.black),
    Icon(Icons.task_alt, color: AppColors.black),
  ),
];

// // class NavigationDrawerApp extends StatelessWidget {
// //   const NavigationDrawerApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(useMaterial3: true),
// //       home: const NavigationDrawerExample(),
// //     );
// //   }
// // }

class NavigationDrawerExample extends StatefulWidget {
  const NavigationDrawerExample({super.key});

  @override
  State<NavigationDrawerExample> createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  Widget buildBottomBarScaffold() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[Text('Page Index = $screenIndex')],
      ),
    );

    // Scaffold(
    //   drawer: Drawer(
    //     child: ListView(
    //       children: [
    //         DrawerHeader(child: Text('Menú')),
    //         ListTile(title: Text('Opción 1')),
    //       ],
    //     ),
    //   ),
    //   appBar: AppBar(
    //     backgroundColor: AppColors.primary,
    //     title: Text(
    //       "Todo List App",
    //       style: const TextStyle(color: AppColors.white),
    //     ),
    //     leading: IconButton(
    //       tooltip: 'Open navigation menu',
    //       icon: const Icon(Icons.menu),
    //       color: AppColors.white,
    //       onPressed: () {
    //         scaffoldKey.currentState?.openDrawer();
    //       },
    //     ),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[Text('Page Index = $screenIndex')],
    //     ),
    //   ),
    //   bottomNavigationBar: NavigationBar(
    //     selectedIndex: screenIndex,
    //     onDestinationSelected: (int index) {
    //       setState(() {
    //         screenIndex = index;
    //       });
    //     },
    //     destinations:
    //         destinations.map((ExampleDestination destination) {
    //           return NavigationDestination(
    //             label: destination.label,
    //             icon: destination.icon,
    //             selectedIcon: destination.selectedIcon,
    //             tooltip: destination.label,
    //           );
    //         }).toList(),
    //   ),
    // );
  }

  Widget buildDrawerScaffold(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: NavigationRail(
                minWidth: 50,
                destinations:
                    destinations.map((ExampleDestination destination) {
                      return NavigationRailDestination(
                        label: Text(destination.label),
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                      );
                    }).toList(),
                selectedIndex: screenIndex,
                useIndicator: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    screenIndex = index;
                  });
                },
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Page Index = $screenIndex'),
                  ElevatedButton(
                    onPressed: openDrawer,
                    child: const Text('Open Drawer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavigationDrawer(
        onDestinationSelected: handleScreenChanged,
        selectedIndex: screenIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Header',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ...destinations.map((ExampleDestination destination) {
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
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 450;
  }

  @override
  Widget build(BuildContext context) {
    return showNavigationDrawer
        ? buildDrawerScaffold(context)
        : buildBottomBarScaffold();
    // return buildBottomBarScaffold();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;

  void _goToAddTaskScreen() {
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FormTaskPage(title: 'Add Task'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la key al Scaffold
      appBar: AppBar(
        title: Text('Todo List App', style: TextStyle(color: AppColors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.white),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // Usa la key para abrir el Drawer
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menú')),
            ListTile(title: Text('Opción 1')),
          ],
        ),
      ),
      body: NavigationDrawerExample(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: _goToAddTaskScreen,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        backgroundColor: AppColors.primary,
        indicatorColor: AppColors.primaryAccent,
        destinations:
            destinations.map((ExampleDestination destination) {
              return NavigationDestination(
                label: destination.label,
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
                tooltip: destination.label,
              );
            }).toList(),
      ),
    );
  }
}
