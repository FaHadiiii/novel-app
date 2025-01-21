import 'package:get/get.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/app/modules/auth/views/sign_in_view.dart';
import 'package:novel/app/modules/auth/views/sign_up_view.dart';
import 'package:novel/app/modules/auth/views/splash_screen.dart';
import 'package:novel/app/modules/auth/views/validate_otp_view.dart';
import 'package:novel/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:novel/app/modules/bookmark/views/bookmark_view.dart';
import 'package:novel/app/modules/detail/controllers/detail_controller.dart';
import 'package:novel/app/modules/detail/views/detail_view.dart';
import 'package:novel/app/modules/home/controllers/home_controller.dart';
import 'package:novel/app/modules/home/views/home_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => DetailView(),
      binding: BindingsBuilder(() {
        Get.put(DetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.bookmark,
      page: () => BookmarkView(),
      binding: BindingsBuilder(() {
        Get.put(BookmarkController());
      }),
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => SignInView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUpView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.validateOtp,
      page: () => ValidateOtpView(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
  ];
}
