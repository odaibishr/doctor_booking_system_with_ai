import 'package:dio/dio.dart';
import 'package:doctor_booking_system_with_ai/core/errors/error_model.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);

  @override
  String toString() => errorModel.errorMessage;
}

//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

handleDioException(DioException e) {
  ErrorModel buildErrorModel({int? overrideStatus}) {
    final status = overrideStatus ?? e.response?.statusCode ?? 500;
    final data = e.response?.data;
    if (data is Map) {
      try {
        return ErrorModel.fromJson(data);
      } catch (_) {
        // fall through to default
      }
    }
    final message = e.message ?? e.error?.toString() ?? 'حدث خطأ غير متوقع';
    return ErrorModel(status: status, errorMessage: message);
  }

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(buildErrorModel());
    case DioExceptionType.badCertificate:
      throw BadCertificateException(buildErrorModel());
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(buildErrorModel());
    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(buildErrorModel());
    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(buildErrorModel());
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      switch (code) {
        case 400:
          throw BadResponseException(buildErrorModel(overrideStatus: 400));
        case 401:
          throw UnauthorizedException(buildErrorModel(overrideStatus: 401));
        case 403:
          throw ForbiddenException(buildErrorModel(overrideStatus: 403));
        case 404:
          throw NotFoundException(buildErrorModel(overrideStatus: 404));
        case 409:
          throw CofficientException(buildErrorModel(overrideStatus: 409));
        case 504:
          throw BadResponseException(
            ErrorModel(status: 504, errorMessage: 'انتهت مهلة البوابة'),
          );
        default:
          throw BadResponseException(buildErrorModel());
      }
    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: "تم إلغاء الطلب", status: 499),
      );
    case DioExceptionType.unknown:
      throw UnknownException(buildErrorModel());
  }
}
