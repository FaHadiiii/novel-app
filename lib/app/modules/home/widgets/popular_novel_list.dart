import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/home/controllers/home_controller.dart';
import 'package:novel/app/modules/home/models/novel.dart';
import 'package:novel/app/modules/home/widgets/rating_card.dart';
import 'package:sizer/sizer.dart';

class PopularNovelList extends StatelessWidget {
  const PopularNovelList({
    super.key,
    required this.popularNovels,
    required this.controller,
  });

  final RxList<Novel> popularNovels;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: popularNovels.length,
      itemBuilder: (context, index) {
        final novel = popularNovels[index];
        return Padding(
          padding: EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () => controller.navigateToDetails(novel.id),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 20.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: novel.thumbnailUrl == '' ||
                                  novel.thumbnailUrl.isEmpty
                              ? AssetImage('assets/img/placeholder.png')
                              : CachedNetworkImageProvider(
                                  controller.fileUrl + novel.thumbnailUrl,
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.cardColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: RatingCard(
                          rating: novel.ratings.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 30.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        novel.title,
                        style: Get.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        novel.author,
                        style: Get.textTheme.bodySmall
                            ?.copyWith(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
