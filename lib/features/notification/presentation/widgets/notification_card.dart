import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalNotificationCard extends StatelessWidget {
  final NotificationEntity notification;

  const MedicalNotificationCard({
    super.key,
    required this.notification,
  });

  IconData _resolveIcon() {
    switch (notification.type) {
      case 'appointment_created':
        return Icons.calendar_today;
      case 'appointment_confirmed':
        return Icons.check_circle_outline;
      case 'appointment_cancelled':
        return Icons.cancel_outlined;
      case 'appointment_completed':
        return Icons.done_all;
      case 'appointment_reminder':
        return Icons.alarm;
      case 'waitlist_slot_available':
        return Icons.celebration_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppColors.getPrimary(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.getGray100(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.getGray300(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(_resolveIcon(), size: 22, color: primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: FontStyles.subTitle1.copyWith(
                    color: AppColors.getTextPrimary(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notification.message,
                  style: FontStyles.body1.copyWith(
                    color: AppColors.getGray600(context),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('yyyy/MM/dd - HH:mm').format(notification.createdAt),
                  style: FontStyles.body2.copyWith(
                    color: AppColors.getGray400(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
