import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/detail/controllers/detail_controller.dart';
import 'package:novel/app/modules/detail/widgets/detail_loading_shimmer.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/widgets/error_screen.dart';
import 'package:novel/common/widgets/theme_toggle.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class DetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailController>();
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            PhosphorIconsRegular.caretLeft,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        actions: [
          IconButton(
            highlightColor: Colors.transparent,
            onPressed: themeController.toggleTheme,
            icon: ThemeToggle(themeController: themeController),
          ),
          SizedBox(
            width: 10,
          ),
          Obx(() {
            return IconButton(
              highlightColor: Colors.transparent,
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                if (controller.isBookmarked.value) {
                  controller.removeNovelFromBookmarks();
                } else {
                  controller.saveNovelToBookmarks();
                }
              },
              icon: Icon(
                controller.isBookmarked.value
                    ? PhosphorIconsFill.bookmarkSimple
                    : PhosphorIconsRegular.bookmarkSimple,
                color: controller.isBookmarked.value
                    ? Get.theme.primaryColor
                    : Get.textTheme.bodyLarge?.color,
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.failToLoad.value) {
          return ErrorScreen(
            controller: controller,
            onRefresh: controller.onRefresh,
          );
        }

        if (controller.novelData.value == null) {
          return DetailLoadingShimmer();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              _NovelDetailTopView(controller: controller),
              SizedBox(
                height: 5.h,
              ),
              Text(
                controller.novelData.value!.summary,
                style: Get.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 4.0,
                runSpacing: 4.0,
                children:
                    controller.novelData.value!.genre.split(',').map((genre) {
                  genre = genre.trim();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(
                        genre,
                        style: Get.textTheme.bodySmall,
                      ),
                      selected: false,
                      backgroundColor: Colors.transparent,
                      disabledColor: Get.theme.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        );
      }),
    );
  }
}

Widget _NovelDetailTopView({required DetailController controller}) {
  return Center(
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 25.h,
            width: 35.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: controller.novelData.value?.thumbnailUrl == null ||
                      controller.novelData.value!.thumbnailUrl.isEmpty
                  ? DecorationImage(
                      image: AssetImage('assets/img/placeholder.png'),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: CachedNetworkImageProvider(
                        controller.fileUrl +
                            controller.novelData.value!.thumbnailUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          controller.novelData.value!.author,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Get.textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
        SizedBox(
          height: 1.5.h,
        ),
        Text(
          controller.novelData.value!.title,
          style: Get.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 2.h,
        ),
        RatingStars(
          value: controller.novelData.value!.ratings,
          starBuilder: (index, color) => Icon(
            PhosphorIconsFill.star,
            color: color,
            size: 18,
          ),
          starCount: 5,
          starSize: 20,
          valueLabelVisibility: true,
          valueLabelColor: Get.theme.cardColor,
          valueLabelTextStyle: Get.textTheme.bodySmall!,
          valueLabelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
      ],
    ),
  );
}
