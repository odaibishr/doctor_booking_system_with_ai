import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/app_notification.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class NotificationService {
  NotificationService(this._navigatorKey);

  final GlobalKey<NavigatorState> _navigatorKey;

  BuildContext? get _rootContext => _navigatorKey.currentContext;

  void show(AppNotification notification, {BuildContext? context}) {
    final toastContext = context ?? _rootContext;
    if (toastContext == null) return;

    toastification.show(
      context: toastContext,
      title: Text(notification.title),
      description: (notification.description?.isNotEmpty ?? false)
          ? Text(notification.description!)
          : null,
      type: _mapType(notification.type),
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: notification.duration ?? const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 280),
      pauseOnHover: false,
      showProgressBar: false,
      dragToClose: true,
      primaryColor: _mapColor(notification.type),
      backgroundColor: Colors.white,
      foregroundColor: AppColors.black,
    );
  }

  void showSuccess(
    String message, {
    String? description,
    Duration? duration,
    BuildContext? context,
  }) {
    show(
      AppNotification.success(
        message,
        description: description,
        duration: duration,
      ),
      context: context,
    );
  }

  void showError(
    String message, {
    String? description,
    Duration? duration,
    BuildContext? context,
  }) {
    show(
      AppNotification.error(
        message,
        description: description,
        duration: duration,
      ),
      context: context,
    );
  }

  void showFailure(
    Failure failure, {
    String? fallbackMessage,
    Duration? duration,
    BuildContext? context,
  }) {
    show(
      AppNotification.fromFailure(
        failure,
        fallbackMessage: fallbackMessage,
        duration: duration,
      ),
      context: context,
    );
  }

  Color _mapColor(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.success:
        return AppColors.gray500;
      case AppNotificationType.error:
        return AppColors.error;
      case AppNotificationType.warning:
        return AppColors.yellow;
      case AppNotificationType.info:
        return AppColors.primary;
    }
  }

  ToastificationType _mapType(AppNotificationType type) {
    switch (type) {
      case AppNotificationType.success:
        return ToastificationType.success;
      case AppNotificationType.error:
        return ToastificationType.error;
      case AppNotificationType.warning:
        return ToastificationType.warning;
      case AppNotificationType.info:
        return ToastificationType.info;
    }
  }
}
