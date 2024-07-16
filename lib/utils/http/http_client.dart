import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String baseUrl = 'https://api.outfit4rent.online';

  static Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    return _request('GET', endpoint, queryParameters: queryParameters);
  }

  static Future<String> getRaw(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final token = await _getToken();
      final headers = _buildHeaders(token);
      final url = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParameters);

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        throw Exception('Token expired or invalid.');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('GET Request Error: $e');
        print('Stacktrace: $stacktrace');
      }
      rethrow;
    }
  }

  static Future<dynamic> post(String endpoint, dynamic data) async {
    return _request('POST', endpoint, data: data);
  }

  static Future<dynamic> put(String endpoint, dynamic data) async {
    return _request('PUT', endpoint, data: data);
  }

  static Future<dynamic> patch(String endpoint, dynamic data) async {
    return _request('PATCH', endpoint, data: data);
  }

  static Future<dynamic> delete(String endpoint) async {
    return _request('DELETE', endpoint);
  }

  static Future<dynamic> _request(String method, String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final token = await _getToken();
      final headers = _buildHeaders(token);
      final url = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParameters);

      http.Response response;

      switch (method) {
        case 'POST':
          response = await http.post(url, headers: headers, body: json.encode(data));
          break;
        case 'PUT':
          response = await http.put(url, headers: headers, body: json.encode(data));
          break;
        case 'PATCH':
          response = await http.patch(url, headers: headers, body: json.encode(data));
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers);
          break;
        case 'GET':
        default:
          response = await http.get(url, headers: headers);
      }

      return _handleResponse(response);
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('$method Request Error: $e');
        print('Stacktrace: $stacktrace');
      }
      rethrow;
    }
  }

  static Future<String?> _getToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return await user.getIdToken();
    } else {
      throw Exception('User not authenticated');
    }
  }

  static Map<String, String> _buildHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception('Failed to decode response body: $e');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Token expired or invalid.');
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
