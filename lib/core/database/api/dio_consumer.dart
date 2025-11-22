import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:doctor_booking_system_with_ai/core/database/api/api_consumer.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/errors/error_model.dart';
import 'package:doctor_booking_system_with_ai/core/errors/exceptions.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';

class DioConsumer extends ApiConsumer {
  final Dio _dio;
  final AuthLocalDataSource authLocalDataSource;

  DioConsumer({required Dio dio, required this.authLocalDataSource})
    : _dio = dio {
    _dio.options
      ..baseUrl = _resolveBaseUrl(EndPoints.baseUrl)
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 20)
      ..responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    try {
      log("Starting to get token");
      final authData = await authLocalDataSource.getCachedAuthData();
      log("Token: ${authData?.token}");
      return authData?.token ?? '';
    } catch (e) {
      log('Error getting token: $e');
      return null;
    }
  }

  String _resolveBaseUrl(String? base) {
    if (base == null || base.isEmpty) {
      throw ServerException(
        ErrorModel(status: 400, errorMessage: 'Base URL cannot be empty'),
      );
    }

    String cleanedBase = base.replaceAll(RegExp(r'/$'), '');

    log('🔄 Final Base URL: $cleanedBase');
    return cleanedBase;
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      if (!path.startsWith('/')) path = '/$path';

      log('🌐 Full URL: ${_dio.options.baseUrl}$path');
      log('📤 Request data: $data');

      final response = await _dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options:
            options ??
            Options(
              validateStatus: (status) => status! < 500,
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
      );

      log('✅ Status: ${response.statusCode}');
      log('📥 Response: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      log('❌ Dio Error: ${e.message}');
      if (e.response != null) {
        log('Status: ${e.response?.statusCode}');
        log('Data: ${e.response?.data}');
      }
      rethrow;
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
