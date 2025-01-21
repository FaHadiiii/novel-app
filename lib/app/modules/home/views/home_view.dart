import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/home/widgets/home_search_bar.dart';
import 'package:novel/common/widgets/error_screen.dart';
import 'package:novel/common/widgets/main_appbar.dart';
import 'package:novel/common/widgets/not_found_screen.dart';
import 'package:novel/common/widgets/novel_grid_view.dart';
import 'package:novel/app/modules/home/widgets/popular_novel_list.dart';
import 'package:novel/common/controllers/theme_controller.dart';
import 'package:novel/app/modules/home/widgets/shimmer_loading_gridview.dart';
import 'package:novel/app/modules/home/widgets/shimmer_loading_listview.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final themeController = Get.find<ThemeController>();
    final FocusNode searchBarFocusNode = FocusNode();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppbar(
        themeController: themeController,
        title: 'Novel',
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Get.theme.primaryColor,
        onRefresh: () async {
          controller.initData();
        },
        child: Obx(() {
          if (controller.failToLoad.value) {
            return ErrorScreen(
              controller: controller,
              onRefresh: controller.onRefresh,
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeSearchBar(searchBarFocusNode: searchBarFocusNode),
                SizedBox(height: 3.5.h),
                if (controller.novelQuery.value.isEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Now',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 28.h,
                    child: Obx(() {
                      final popularNovels = controller.popularNovelList;

                      if (popularNovels.isEmpty) {
                        return ShimmerLoadingListview(itemCount: 5);
                      }

                      return PopularNovelList(
                          popularNovels: popularNovels, controller: controller);
                    }),
                  ),
                  SizedBox(height: 2.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Novels',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (details) async {
                          final tapPosition = details.globalPosition;
                          controller.sortNovelList(context, tapPosition);
                        },
                        child: Icon(
                          Icons.filter_list_rounded,
                          size: 5.5.w,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Obx(() {
                    final novels = controller.novelList;

                    if (novels.isEmpty) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 30,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ShimmerLoadingGridview();
                        },
                      );
                    }

                    return NovelGridView(
                        novels: novels, controller: controller);
                  }),
                  SizedBox(
                    height: 3.h,
                  ),
                ] else ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Result for ',
                          style: Get.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: controller.novelQuery.value,
                              style: Get.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.5.h),
                      Obx(() {
                        if (controller.filteredNovelList.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 10.h),
                              Center(
                                child: NotFoundScreen(
                                  message: "No matching novel found",
                                ),
                              ),
                            ],
                          );
                        }

                        final novels = controller.filteredNovelList;

                        return NovelGridView(
                          novels: novels,
                          controller: controller,
                        );
                      }),
                      SizedBox(height: 3.h),
                    ],
                  )
                ],
              ],
            ),
          );
        }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 15),
        child: FloatingActionButton(
          backgroundColor: Get.theme.primaryColor.withOpacity(1),
          onPressed: () => controller.navigateToBookmark(),
          child: Icon(
            PhosphorIconsFill.bookmarkSimple,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
