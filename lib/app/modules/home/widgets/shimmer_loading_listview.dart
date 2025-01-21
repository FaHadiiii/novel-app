import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerLoadingListview extends StatelessWidget {
  final int itemCount;

  const ShimmerLoadingListview({Key? key, this.itemCount = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.05),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Container(
                  height: 20.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.theme.cardColor,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.05),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Get.theme.cardColor,
                  ),
                  height: 14.0,
                  width: 30.w,
                ),
              ),
              SizedBox(height: 0.5.h),
              Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.05),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Get.theme.cardColor,
                  ),
                  height: 12.0,
                  width: 20.w,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
