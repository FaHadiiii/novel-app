import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    super.key,
    required this.themeController,
  });

  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: Offset(0.0, -0.5),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        child: Icon(
          themeController.isDarkMode.value
              ? PhosphorIconsRegular.sun
              : PhosphorIconsRegular.moon,
          key: ValueKey<bool>(themeController.isDarkMode.value),
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      );
    });
  }
}
