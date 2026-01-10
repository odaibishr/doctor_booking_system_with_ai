import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      ..responseType = ResponseType.plain;

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
      final authData = await authLocalDataSource.getCachedAuthData();
      return authData?.token;
    } catch (_) {
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
    if (!kIsWeb && Platform.isAndroid) {
      cleanedBase = cleanedBase.replaceFirst(RegExp(r'http:'), 'http:');
    }
    return cleanedBase;
  }

  dynamic _parseResponse(dynamic data) {
    try {
      String responseStr = data.toString();
      final firstBraceIndex = responseStr.indexOf('{');
      if (firstBraceIndex != -1) {
        responseStr = responseStr.substring(firstBraceIndex);
      }
      return jsonDecode(responseStr);
    } catch (e) {
      log('Failed to parse response as JSON: $e');
      return {'raw_response': data};
    }
  }

  Future<dynamic> _request(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    if (!path.startsWith('/')) path = '/$path';
    log('🌐 Full URL: ${_dio.options.baseUrl}$path');
    log('📤 Request data: $data');

    try {
      Response response;

      switch (method.toLowerCase()) {
        case 'post':
          response = await _dio.post(
            path,
            data: isFormData ? FormData.fromMap(data) : data,
            queryParameters: queryParameters,
            options:
                options ??
                Options(
                  validateStatus: (status) => status! < 500,
                  responseType: ResponseType.plain,
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                ),
          );
          break;

        case 'get':
          response = await _dio.get(
            path,
            queryParameters: queryParameters,
            options:
                options ??
                Options(
                  validateStatus: (status) => status! < 500,
                  responseType: ResponseType.plain,
                ),
          );
          break;

        case 'delete':
          response = await _dio.delete(
            path,
            queryParameters: queryParameters,
            options:
                options ??
                Options(
                  validateStatus: (status) => status! < 500,
                  responseType: ResponseType.plain,
                ),
          );
          break;

        case 'patch':
          response = await _dio.patch(
            path,
            data: isFormData ? FormData.fromMap(data) : data,
            queryParameters: queryParameters,
            options:
                options ??
                Options(
                  validateStatus: (status) => status! < 500,
                  responseType: ResponseType.plain,
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                ),
          );
          break;

        case 'put':
          response = await _dio.put(
            path,
            data: isFormData ? FormData.fromMap(data) : data,
            queryParameters: queryParameters,
            options:
                options ??
                Options(
                  validateStatus: (status) => status! < 500,
                  responseType: ResponseType.plain,
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                ),
          );
          break;

        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      log('✅ Status: ${response.statusCode}');
      log('📥 Response data: ${response.data}');

      final parsedResponse = _parseResponse(response.data);
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw ServerException(ErrorModel.fromJson(parsedResponse));
      }

      return parsedResponse;
    } on DioException catch (e) {
      log('❌ Dio Error: ${e.message}');
      if (e.response != null) {
        return _parseResponse(e.response!.data);
      }
      rethrow;
    } catch (e) {
      log('❌ Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) => _request(
    'post',
    path,
    data: data,
    queryParameters: queryParameters,
    isFormData: isFormData,
    options: options,
  );

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) => _request('get', path, queryParameters: queryParameters);

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) => _request('delete', path, queryParameters: queryParameters);

  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) => _request(
    'patch',
    path,
    data: data,
    queryParameters: queryParameters,
    isFormData: isFormData,
  );

  @override
  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) => _request(
    'put',
    path,
    data: data,
    queryParameters: queryParameters,
    isFormData: isFormData,
  );
}
