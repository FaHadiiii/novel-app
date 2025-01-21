import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/common/widgets/button_loading_indicator.dart';
import 'package:sizer/sizer.dart';

class SigninSignupButton extends StatelessWidget {
  final String label;
  final String subLabel;
  final String oppositeFormLabel;
  final VoidCallback onButtonSubmit;
  final VoidCallback onSwitchForm;

  const SigninSignupButton({
    super.key,
    required this.controller,
    required this.label,
    required this.subLabel,
    required this.onButtonSubmit,
    required this.onSwitchForm,
    required this.oppositeFormLabel,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 15),
          child: ElevatedButton(
              onPressed: () async {
                onButtonSubmit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Obx(() {
                return controller.loadingAuth.value
                    ? ButtonLoadingIndicator(color: Colors.white)
                    : Text(
                        label,
                        style: Get.textTheme.bodyMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
              })),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: subLabel,
                style: Theme.of(context).textTheme.bodyMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: oppositeFormLabel,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        onSwitchForm();
                      },
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ],
    );
  }
}
