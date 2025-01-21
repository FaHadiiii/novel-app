import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.controller,
    required this.onRefresh,
  });

  final dynamic controller;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/error/error-occured.svg',
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(height: 4.h),
          Text(
            'Opps!',
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'It seems something went wrong',
            style: Get.textTheme.bodyMedium,
          ),
          TextButton.icon(
            icon: Icon(
              PhosphorIconsRegular.arrowCounterClockwise,
              size: 20.sp,
            ),
            onPressed: () {
              onRefresh();
            },
            label: Text("Try Again",
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: Get.theme.primaryColor,
                )),
            style: TextButton.styleFrom(
              foregroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 20.w,
              ),
              iconColor: Get.theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
