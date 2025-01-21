import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:novel/common/environments/env.dart';

class ApiBase {
  final String baseUrl = Env().baseUrl;
  final String bearerToken = Env().bearerToken;

  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Request to $endpoint failed: $e');
    }
  }

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            body: json.encode(body),
            headers: headers,
          )
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Request to $endpoint failed: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
