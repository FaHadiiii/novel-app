import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/app/modules/auth/widgets/signin_signup_button.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/widgets/main_appbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MainAppbar(
        themeController: themeController,
        title: 'Sign Up',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              'Enter all details and click sign up to proceed.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Get.textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 2.h,
            ),
            _FormTextField(controller.emailController, 'Email',
                PhosphorIconsRegular.envelope, controller),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _FormTextField(
                    controller.firstNameController,
                    'First Name',
                    PhosphorIconsRegular.user,
                    controller,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _FormTextField(
                    controller.lastNameController,
                    'Last Name',
                    null,
                    controller,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            customDropdownButton(
              selectedValue: controller.selectedGender.value,
              items: ['Male', 'Female'],
              onChanged: (value) {
                if (value != null) {
                  controller.selectedGender.value = value;
                }
              },
              prefixIcon: PhosphorIconsRegular.person,
            ),
            SizedBox(height: 2.h),
            customDropdownButton(
              selectedValue: controller.selectedCountry.value,
              items: controller.countryCodes.map((code) {
                return code.name.length > 20
                    ? code.name.substring(0, 20) + '...' + " (${code.code})"
                    : code.name + " (${code.code})";
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  final code =
                      RegExp(r'\(([^)]+)\)').firstMatch(value)?.group(1);
                  if (code != null) {
                    controller.selectedCountry.value = value;
                    controller.setDialAndCountryCode(code);
                  }
                }
              },
              prefixIcon: PhosphorIconsRegular.globeHemisphereEast,
            ),
            SizedBox(height: 2.h),
            _FormTextField(
              controller.phoneController,
              'Phone Number',
              PhosphorIconsRegular.phone,
              controller,
            ),
            SizedBox(height: 3.h),
            SigninSignupButton(
              controller: controller,
              label: "Sign Up",
              subLabel: "Already have an account?  ",
              onButtonSubmit: () => controller.signUp(),
              onSwitchForm: () => controller.navigateToSignIn(),
              oppositeFormLabel: "Sign In",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _FormTextField(TextEditingController inputController, String hintText,
    IconData? icon, AuthController controller) {
  return TextField(
    controller: inputController,
    style: Get.textTheme.bodyMedium?.copyWith(overflow: TextOverflow.ellipsis),
    cursorColor: Colors.grey.shade600,
    decoration: InputDecoration(
      prefixIcon: icon == null
          ? null
          : IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    icon,
                    size: 20,
                    color: Get.textTheme.bodyLarge?.color?.withOpacity(0.6),
                  ),
                  const SizedBox(width: 15),
                  if (hintText == "Phone Number") ...[
                    Obx(() {
                      return Text(
                        controller.dialCode.value,
                        style: Get.textTheme.bodyMedium,
                      );
                    }),
                    const SizedBox(width: 15),
                  ]
                ],
              ),
            ),
      hintText: hintText,
      hintStyle: Get.textTheme.bodyMedium?.copyWith(
        color: Get.textTheme.bodyMedium?.color?.withOpacity(0.3),
      ),
      filled: true,
      fillColor: Get.theme.cardColor,
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
  );
}

Widget customDropdownButton({
  required String? selectedValue,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  required IconData prefixIcon,
  double iconSize = 20.0,
}) {
  return DropdownButtonFormField<String>(
    icon: Icon(
      PhosphorIconsRegular.caretDown,
      size: 5.w,
    ),
    value: selectedValue,
    decoration: InputDecoration(
      prefixIcon: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            Icon(
              prefixIcon,
              size: iconSize,
              color: Get.textTheme.bodyLarge?.color?.withOpacity(0.6),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      filled: true,
      fillColor: Get.theme.cardColor,
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
    items: items
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: Get.textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList(),
    onChanged: onChanged,
    dropdownColor: Get.theme.cardColor,
    style: Get.textTheme.bodyMedium,
  );
}
