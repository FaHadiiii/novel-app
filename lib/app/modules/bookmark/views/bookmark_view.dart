import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/common/widgets/not_found_screen.dart';
import 'package:novel/common/widgets/novel_grid_view.dart';
import 'package:novel/common/widgets/theme_toggle.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class BookmarkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookmarkController>();
    var themeController = Get.find<ThemeController>();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmark",
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
          actions: [
            IconButton(
              highlightColor: Colors.transparent,
              padding: EdgeInsets.only(right: 15),
              onPressed: themeController.toggleTheme,
              icon: ThemeToggle(themeController: themeController),
            ),
          ],
        ),
        body: Obx(() {
          final novels = controller.bookmarkedNovels;
          if (novels.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: NotFoundScreen(
                    message: "No bookmarked novel found",
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text.rich(
                      TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text: '${novels.length}',
                            style: Get.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' bookmark found',
                            style: Get.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    NovelGridView(novels: novels, controller: controller),
                    SizedBox(height: 3.h),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
