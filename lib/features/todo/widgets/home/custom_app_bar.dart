import 'package:flutter/material.dart';
import 'package:flutter_todo_list_app/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: AppColors.white)),
      leading: IconButton(
        icon: Icon(Icons.menu, color: AppColors.white),
        onPressed: () {
          scaffoldKey.currentState
              ?.openDrawer(); // Usa la key para abrir el Drawer
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
