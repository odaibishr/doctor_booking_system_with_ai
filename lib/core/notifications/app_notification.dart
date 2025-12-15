import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';

enum AppNotificationType { success, error, info, warning }

class AppNotification {
  final AppNotificationType type;
  final String title;
  final String? description;
  final Duration? duration;

  const AppNotification({
    required this.type,
    required this.title,
    this.description,
    this.duration,
  });

  factory AppNotification.success(
    String title, {
    String? description,
    Duration? duration,
  }) {
    return AppNotification(
      type: AppNotificationType.success,
      title: title,
      description: description,
      duration: duration,
    );
  }

  factory AppNotification.error(
    String title, {
    String? description,
    Duration? duration,
  }) {
    return AppNotification(
      type: AppNotificationType.error,
      title: title,
      description: description,
      duration: duration,
    );
  }

  factory AppNotification.info(
    String title, {
    String? description,
    Duration? duration,
  }) {
    return AppNotification(
      type: AppNotificationType.info,
      title: title,
      description: description,
      duration: duration,
    );
  }

  factory AppNotification.warning(
    String title, {
    String? description,
    Duration? duration,
  }) {
    return AppNotification(
      type: AppNotificationType.warning,
      title: title,
      description: description,
      duration: duration,
    );
  }

  factory AppNotification.fromFailure(
    Failure failure, {
    String? fallbackMessage,
    Duration? duration,
  }) {
    return AppNotification.error(
      (failure.errorMessage).trim().isNotEmpty
          ? failure.errorMessage
          : (fallbackMessage ?? 'حدث خطأ غير متوقع، حاول لاحقاً'),
      duration: duration,
    );
  }

  AppNotification copyWith({
    AppNotificationType? type,
    String? title,
    String? description,
    Duration? duration,
  }) {
    return AppNotification(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
    );
  }
}
