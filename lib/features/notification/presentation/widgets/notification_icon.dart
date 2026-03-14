import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  final NotificationEntity notification;
  const NotificationIcon({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color = context.primaryColor;

    switch (notification.type) {
      case 'appointment_created':
        icon = Icons.calendar_today;
      case 'appointment_confirmed':
        icon = Icons.check_circle;
      case 'appointment_cancelled':
        icon = Icons.cancel;
      case 'appointment_completed':
        icon = Icons.done_all;
      case 'appointment_reminder':
        icon = Icons.alarm;
      case 'waitlist_slot_available':
        icon = Icons.celebration;
      default:
        icon = Icons.notifications_active;
    }

    return Icon(icon, color: color, size: 22);
  }
}
