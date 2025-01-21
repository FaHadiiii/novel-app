import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/app/routes/app_pages.dart';
import 'package:novel/app/routes/app_routes.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/environments/env.dart';
import 'package:novel/common/themes/theme.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.loadEnv().then((v) => print("Successfully LoadENV"));
  await GetStorage.init();
  final themeController = Get.put(ThemeController());
  await themeController.initTheme();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(() {
          final themeController = Get.find<ThemeController>();
          return GetMaterialApp(
            defaultTransition: Transition.cupertino,
            title: 'Novel',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.pages,
            initialRoute: AppRoutes.splashscreen,
            onReady: () => Get.find<AuthController>().isLoggedIn(),
          );
        });
      },
    );
  }
}
