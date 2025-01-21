import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class DetailLoadingShimmer extends StatelessWidget {
  const DetailLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 3.h),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.05),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: Container(
                height: 25.h,
                width: 35.w,
                decoration: BoxDecoration(
                  color: Get.theme.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.05),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Container(
              height: 16,
              width: 120,
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 1.5.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.05),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Container(
              height: 24,
              width: 200,
              decoration: BoxDecoration(
                color: Get.theme.cardColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.05),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.05),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Column(
              children: List.generate(
                15,
                (index) {
                  double screenWidth = MediaQuery.of(context).size.width;

                  double randomWidth =
                      Random().nextDouble() * (screenWidth * 0.4) +
                          (screenWidth * 0.5);

                  return Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Container(
                      height: 16,
                      width: randomWidth,
                      decoration: BoxDecoration(
                        color: Get.theme.cardColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
