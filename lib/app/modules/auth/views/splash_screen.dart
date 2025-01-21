import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Novel',
          style: Get.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold, color: Get.theme.primaryColor),
        ),
      ),
    );
  }
}
