import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novel/app/modules/home/models/novel.dart';
import 'package:novel/app/routes/app_routes.dart';
import 'package:novel/common/api/api_endpoint.dart';
import 'package:novel/common/environments/env.dart';
import 'package:novel/common/services/storage_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeController extends GetxController {
  final novelList = <Novel>[].obs;
  final popularNovelList = <Novel>[].obs;
  final filteredNovelList = <Novel>[].obs;
  var novelQuery = ''.obs;
  var failToLoad = false.obs;

  final String fileUrl = Env().fileUrl;

  final storageService = StorageService();

  onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    novelList.clear();
    popularNovelList.clear();
    await fetchNovelList();
  }

  Future<void> onRefresh() async {
    failToLoad.value = false;
    await fetchNovelList();
  }

  Future<void> fetchNovelList() async {
    try {
      var res;
      try {
        res = await ApiEndpoint().fetchNovelList();
        if (res == null) {
          res = await storageService.readNovelList();
        } else {
          await storageService.saveNovelList(res);
        }
      } catch (e) {
        print(e);
        res = await storageService.readNovelList();
      }

      novelList.value = (res['data'] as List)
          .map((novelJson) => Novel.fromJson(novelJson))
          .toList();
      popularNovels();
    } catch (e) {
      print('Error fetching novels: $e');
      failToLoad.value = true;
    }
  }

  void searchNovels() {
    if (novelQuery.value.isEmpty) {
      filteredNovelList.value = List.from(novelList);
    } else {
      filteredNovelList.value = novelList.where((novel) {
        return novel.title.toLowerCase().contains(
              novelQuery.value.toLowerCase(),
            );
      }).toList();
    }
  }

  void popularNovels() {
    final random = Random();
    final shuffledList = novelList.toList()..shuffle(random);
    popularNovelList.value = shuffledList.take(5).toList();
  }

  void sortNovelList(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      color: Get.theme.cardColor,
      items: [
        PopupMenuItem(
          value: 'title',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort by Title',
                style: Get.textTheme.bodySmall,
              ),
              Icon(
                PhosphorIconsRegular.textAa,
                color: Get.theme.primaryColor,
                size: 18,
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 'rating',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort by Rating',
                style: Get.textTheme.bodySmall,
              ),
              Icon(
                PhosphorIconsRegular.star,
                color: Get.theme.primaryColor,
                size: 18,
              )
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'title') {
        sortByTitle();
      } else if (value == 'rating') {
        sortByRating();
      }
    });
  }

  void sortByTitle() {
    novelList.sort((a, b) => a.title.compareTo(b.title));
  }

  void sortByRating() {
    novelList.sort((a, b) => b.ratings.compareTo(a.ratings));
  }

  void navigateToBookmark() {
    Get.toNamed(AppRoutes.bookmark);
  }

  void navigateToDetails(int id) {
    Get.toNamed(AppRoutes.detail, arguments: [id, false]);
  }
}
