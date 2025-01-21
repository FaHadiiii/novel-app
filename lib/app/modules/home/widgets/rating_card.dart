import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class RatingCard extends StatelessWidget {
  final String rating;
  const RatingCard({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.star,
            color: Colors.amber,
            size: 3.5.w,
          ),
          SizedBox(width: 5),
          Text(
            "${rating}",
            style: Get.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
