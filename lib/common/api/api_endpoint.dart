import 'api_base.dart';

class ApiEndpoint {
  final ApiBase _apiBase = ApiBase();

  Future<Map<String, dynamic>?> fetchNovelList() async {
    try {
      final response = await _apiBase.get('/fetchNovel');
      return response;
    } catch (e) {
      print('Error fetching novel list: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchNovelDetail(int id) async {
    try {
      final response = await _apiBase.get('/novel/${id}?htmlToText=1');
      return response;
    } catch (e) {
      print('Error fetching novel detail: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> signIn(String email) async {
    try {
      Map<String, String> body = {"identifier": email};
      final response = await _apiBase.post('/login', body);
      return response;
    } catch (e) {
      throw Exception('Error fetching novel list: $e');
    }
  }

  Future<Map<String, dynamic>> signUp(Map<String, String> userData) async {
    try {
      final response = await _apiBase.post('/register', userData);
      return response;
    } catch (e) {
      throw Exception('Error fetching novel list: $e');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      Map<String, String> body = {
        "identifier": email,
        "code": otp,
      };
      final response = await _apiBase.post('/validateOtp', body);
      return response;
    } catch (e) {
      throw Exception('Error fetching novel list: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCountryCode() async {
    try {
      final response = await _apiBase.get('/countryCode');
      return response;
    } catch (e) {
      throw Exception('Error fetching novel list: $e');
    }
  }
}
