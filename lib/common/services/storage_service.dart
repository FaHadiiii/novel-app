import 'package:get_storage/get_storage.dart';
import 'package:novel/app/modules/detail/models/novel_detail.dart';

class StorageService {
  static const String themeModeKey = 'themeMode';
  static const String bookmarksKey = 'bookmarks';
  static const String userAuthKey = 'loggedEmail';
  static const String novelListKey = 'novelList';
  static const String novelDetailKey = 'novelDetail';

  final box = GetStorage();

  Future<void> saveThemeMode(bool isDark) async {
    try {
      await box.write(themeModeKey, isDark);
      print("Is saved dark mode: ${isDark}");
    } catch (e) {
      print('Error saving theme mode: $e');
      rethrow;
    }
  }

  Future<void> saveLoggedIn(String email) async {
    try {
      await box.write(userAuthKey, email);
    } catch (e) {
      print('Error saving email: $e');
      rethrow;
    }
  }

  Future<String?> readLoggedIn() async {
    try {
      final value = await box.read(userAuthKey);
      return value;
    } catch (e) {
      print('Error reading email: $e');
      return null;
    }
  }

  Future<bool> readThemeMode() async {
    try {
      final value = await box.read(themeModeKey);
      print("Current theme is dark: ${value}");
      return value ?? false;
    } catch (e) {
      print('Error reading theme mode: $e');
      return false;
    }
  }

  Future<void> saveNovelToBookmarks(NovelDetail novel) async {
    try {
      List<Map<String, dynamic>> bookmarks = await getBookmarkedNovels();

      Map<String, dynamic> novelMap = {
        'id': novel.id,
        'title': novel.title,
        'author': novel.author,
        'ratings': novel.ratings,
        'thumbnailUrl': novel.thumbnailUrl,
      };

      bookmarks.add(novelMap);

      await box.write(bookmarksKey, bookmarks);
      print("Novel saved to bookmarks");
    } catch (e) {
      print('Error saving novel to bookmarks: $e');
      rethrow;
    }
  }

  Future<void> removeNovelFromBookmarks(int novelId) async {
    try {
      List<Map<String, dynamic>> bookmarks = await getBookmarkedNovels();

      bookmarks.removeWhere((novel) => novel['id'] == novelId);

      await box.write(bookmarksKey, bookmarks);
      print("Novel removed from bookmarks");
    } catch (e) {
      print('Error removing novel from bookmarks: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getBookmarkedNovels() async {
    try {
      final List<dynamic> bookmarks = await box.read(bookmarksKey) ?? [];
      return bookmarks.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error reading bookmarks: $e');
      return [];
    }
  }

  //Save novel list to local storage
  saveNovelList(dynamic data) async {
    try {
      await box.write(novelListKey, data);
      print("Novel list saved to local storage");
    } catch (e) {
      print('Error saving novel list to local storage: $e');
      rethrow;
    }
  }

  dynamic readNovelList() async {
    try {
      final value = await box.read(novelListKey);
      return value;
    } catch (e) {
      print('Error reading novel list from local storage: $e');
      return null;
    }
  }

  //Save novel detail to local storage
  saveNovelDetail(dynamic data, int id) async {
    try {
      await box.write(novelDetailKey + id.toString(), data);
      print("Novel detail saved to local storage");
    } catch (e) {
      print('Error saving novel detail to local storage: $e');
      rethrow;
    }
  }

  dynamic readNovelDetail(int id) async {
    try {
      final value = await box.read(novelDetailKey + id.toString());
      return value;
    } catch (e) {
      print('Error reading novel detail from local storage: $e');
      return null;
    }
  }
}
