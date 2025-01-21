import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/widgets/theme_toggle.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeController themeController;
  final String title;

  const MainAppbar(
      {Key? key, required this.themeController, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.theme.primaryColor,
            ),
      ),
      actions: [
        IconButton(
          highlightColor: Colors.transparent,
          padding: const EdgeInsets.only(right: 15),
          onPressed: themeController.toggleTheme,
          icon: ThemeToggle(themeController: themeController),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
