import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/auth/controllers/auth_controller.dart';
import 'package:novel/common/widgets/button_loading_indicator.dart';
import 'package:novel/common/widgets/custom_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class ValidateOtpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Obx(() {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: AppBar(
            title: Text(
              "Verify OTP Code",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                PhosphorIconsRegular.caretLeft,
                color: Get.textTheme.bodyLarge?.color,
              ),
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.12,
            automaticallyImplyLeading: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                Text(
                  'A verification code send to',
                  style: Get.textTheme.bodyMedium,
                ),
                SizedBox(height: 1.h),
                Text(
                  controller.currentEmail.value,
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: PinCodeTextField(
                    appContext: context,
                    errorTextSpace: 0,
                    length: 6,
                    enableActiveFill: true,
                    autoFocus: true,
                    autoUnfocus: true,
                    cursorColor: Colors.grey,
                    cursorHeight: Get.textTheme.labelLarge?.fontSize,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      fieldWidth: 13.w,
                      fieldHeight: 15.w,
                      activeColor: Get.theme.cardColor,
                      selectedColor:
                          Get.textTheme.bodySmall?.color?.withOpacity(0.6),
                      inactiveColor: Get.theme.cardColor,
                      activeFillColor: Get.theme.cardColor,
                      selectedFillColor: Get.theme.cardColor,
                      inactiveFillColor: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      fieldOuterPadding: EdgeInsets.only(right: 2, left: 2),
                    ),
                    showCursor: true,
                    textStyle: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                    hintStyle: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                    pastedTextStyle: Get.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                    animationType: AnimationType.scale,
                    animationDuration: Duration(milliseconds: 150),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.otpValues.value = value;
                    },
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        if (controller.otpValues.value.length < 6) {
                          customSnackbar(
                            title: 'Invalid OTP',
                            message: 'Please enter valid code',
                            icon: PhosphorIconsRegular.xCircle,
                          );
                        } else {
                          controller.verifyOtp();
                        }
                      },
                      child: Obx(() {
                        return controller.loadingVerifyOtp.value
                            ? ButtonLoadingIndicator(color: Colors.white)
                            : Text(
                                "Submit",
                                style: Get.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                      })),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
