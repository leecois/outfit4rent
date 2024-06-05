import 'package:dio/dio.dart';
import 'package:outfit4rent/utils/constants/api_constants.dart';
import 'package:outfit4rent/utils/helpers/shared_preferences_helper.dart';

class TDioClient {
  static const String _baseUrl = tSecretAPIKey;
  static final Dio _dio = Dio(BaseOptions(baseUrl: _baseUrl));

  TDioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SharedPreferencesHelper.getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _dio.get(endpoint);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response = await _dio.post(endpoint, data: data);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await _dio.put(endpoint, data: data);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await _dio.delete(endpoint);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
