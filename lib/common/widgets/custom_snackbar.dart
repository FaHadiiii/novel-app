import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackbar({
  required String title,
  required String message,
  required IconData icon,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Get.textTheme.bodyLarge?.color,
    colorText: Get.theme.scaffoldBackgroundColor,
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
    icon: Icon(icon, color: Get.theme.scaffoldBackgroundColor),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  );
}
