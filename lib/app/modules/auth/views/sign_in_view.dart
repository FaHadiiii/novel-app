import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/app/modules/auth/widgets/signin_signup_button.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/widgets/main_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: MainAppbar(
        themeController: themeController,
        title: 'Sign In',
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset(
                'assets/img/signin.svg',
                width: 35.w,
                height: 35.h,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: emailController,
                  style: Get.textTheme.bodyMedium,
                  cursorColor: Colors.grey.shade600,
                  decoration: InputDecoration(
                    prefixIcon: IntrinsicHeight(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 15),
                          Icon(
                            PhosphorIconsRegular.envelope,
                            size: 20,
                            color: Get.textTheme.bodyLarge?.color
                                ?.withOpacity(0.6),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    hintText: "Enter your email",
                    hintStyle: Get.textTheme.bodyMedium?.copyWith(
                      color: Get.textTheme.bodyMedium?.color?.withOpacity(0.3),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Get.theme.shadowColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Get.theme.shadowColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                SigninSignupButton(
                  controller: controller,
                  label: "Sign In",
                  subLabel: "Don't have an account?  ",
                  onButtonSubmit: () => controller.signIn(emailController.text),
                  onSwitchForm: () => controller.navigateToSignUp(),
                  oppositeFormLabel: "Sign Up",
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
