import 'package:get/get.dart';
import 'package:novel/app/modules/bookmark/model/novel_bookmark.dart';
import 'package:novel/app/routes/app_routes.dart';
import 'package:novel/common/environments/env.dart';
import 'package:novel/common/services/storage_service.dart';

class BookmarkController extends GetxController {
  var bookmarkedNovels = <NovelBookmark>[].obs;
  final storageService = StorageService();

  final String fileUrl = Env().fileUrl;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    try {
      final bookmarks = await storageService.getBookmarkedNovels();

      bookmarkedNovels.value = bookmarks
          .map<NovelBookmark>((bookmark) => NovelBookmark.fromJson(bookmark))
          .toList();
    } catch (e) {
      print('Error fetching bookmarks: $e');
    }
  }

  void navigateToDetails(int id) {
    Get.toNamed(AppRoutes.detail, arguments: [id, true]);
  }
}
