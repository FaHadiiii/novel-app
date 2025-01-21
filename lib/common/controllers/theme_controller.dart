import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/common/services/storage_service.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final StorageService storageService = StorageService();

  Future<void> initTheme() async {
    isDarkMode.value = await storageService.readThemeMode();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    storageService.saveThemeMode(isDarkMode.value);
  }
}
