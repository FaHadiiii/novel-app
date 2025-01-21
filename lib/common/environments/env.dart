import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static const _baseUrl = "BASE_URL";
  static const _fileUrl = "FILE_URL";
  static const _bearerToken = "API_TOKEN";

  String get baseUrl => _getFromEnv(_baseUrl);
  String get fileUrl => _getFromEnv(_fileUrl);
  String get bearerToken => _getFromEnv(_bearerToken);

  static String _getFromEnv(String varName) {
    try {
      return dotenv.env[varName] ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<void> loadEnv() async => await dotenv.load(fileName: ".env");
}
