import 'package:get/get.dart';
import 'package:novel/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:novel/app/modules/detail/models/novel_detail.dart';
import 'package:novel/common/api/api_endpoint.dart';
import 'package:novel/common/environments/env.dart';
import 'package:novel/common/services/storage_service.dart';

class DetailController extends GetxController {
  final novelId = Get.arguments[0];
  final isFromBookmark = Get.arguments[1];
  var novelData = Rxn<NovelDetail>();
  var isBookmarked = false.obs;
  var failToLoad = false.obs;

  final storageService = StorageService();

  final String fileUrl = Env().fileUrl;

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkBookmark();
    await fetchNovelDetail();
  }

  void onRefresh() async {
    failToLoad.value = false;
    await fetchNovelDetail();
  }

  Future<void> fetchNovelDetail() async {
    try {
      var res;
      try {
        res = await ApiEndpoint().fetchNovelDetail(novelId);
        if (res == null) {
          res = await storageService.readNovelDetail(novelId);
        } else {
          await storageService.saveNovelDetail(res, novelId);
        }
      } catch (e) {
        print(e);
        res = await storageService.readNovelDetail(novelId);
      }

      novelData.value = NovelDetail.fromJson(res['data']);
    } catch (e) {
      print('Error fetching novels: $e');
      failToLoad.value = true;
    }
  }

  Future<void> saveNovelToBookmarks() async {
    if (novelData.value != null) {
      await storageService.saveNovelToBookmarks(novelData.value!);
    }
    checkBookmark();
  }

  Future<void> removeNovelFromBookmarks() async {
    if (novelData.value != null) {
      await storageService.removeNovelFromBookmarks(novelData.value!.id);
    }
    checkBookmark();

    if (isFromBookmark) {
      Get.find<BookmarkController>().fetchBookmarks();
    }
  }

  Future<bool> isNovelBookmarked() async {
    if (novelId != null) {
      final bookmarks = await storageService.getBookmarkedNovels();
      return bookmarks.any((novel) => novel['id'] == novelId);
    }
    return false;
  }

  checkBookmark() async {
    isBookmarked.value = await isNovelBookmarked();
  }
}
