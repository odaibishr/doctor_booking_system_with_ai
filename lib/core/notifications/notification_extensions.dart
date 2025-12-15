import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_service.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';

extension ToastificationContextX on BuildContext {
  NotificationService get _notifier => serviceLocator<NotificationService>();

  void showSuccessToast(
    String message, {
    String? description,
    Duration? duration,
  }) {
    _notifier.showSuccess(
      message,
      description: description,
      duration: duration,
      context: this,
    );
  }

  void showErrorToast(
    String message, {
    String? description,
    Duration? duration,
  }) {
    _notifier.showError(
      message,
      description: description,
      duration: duration,
      context: this,
    );
  }

  void showFailureToast(
    Failure failure, {
    String? fallbackMessage,
    Duration? duration,
  }) {
    _notifier.showFailure(
      failure,
      fallbackMessage: fallbackMessage,
      duration: duration,
      context: this,
    );
  }
}
