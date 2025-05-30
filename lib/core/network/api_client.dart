import 'package:dio/dio.dart';
import 'package:visit_tracker/core/constants/api_constants.dart';


class ApiClient {
  late final Dio _dio;
  
  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'apikey': ApiConstants.apiKey,
        'Authorization': 'Bearer ${ApiConstants.apiKey}',
        'Content-Type': 'application/json',
        'Prefer': 'return=representation', // For Supabase to return data after operations
      },
    ));
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
  
  Dio get dio => _dio;

  // GET request
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // POST request
  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // PUT request
  Future<dynamic> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // PATCH request (commonly used with Supabase)
  Future<dynamic> patch(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // DELETE request
  Future<void> delete(String path) async {
    try {
      await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // Error handling for Dio exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?.toString() ?? 'Unknown error';
        return Exception('Server error ($statusCode): $message');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error: ${error.message}');
    }
  }
}