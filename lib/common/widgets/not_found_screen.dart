import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotFoundScreen extends StatelessWidget {
  final String message;
  const NotFoundScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/error/not-found.svg',
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
            message,
            style: Get.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
