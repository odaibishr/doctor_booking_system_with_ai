import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicalNotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const MedicalNotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.getGray100(context)
              : AppColors.getPrimary(context).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead
                ? AppColors.getGray300(context)
                : AppColors.getPrimary(context).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildIcon(context),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    notification.title,
                    style: FontStyles.subTitle1.copyWith(
                      color: AppColors.getTextPrimary(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (!notification.isRead)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.getPrimary(context),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              notification.message,
              style: FontStyles.body1.copyWith(
                color: AppColors.getGray600(context),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.getPrimary(context),
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat(
                    'yyyy/MM/dd - HH:mm',
                  ).format(notification.createdAt),
                  style: FontStyles.body2.copyWith(
                    color: AppColors.getPrimary(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final IconData icon;
    final Color color;

    switch (notification.type) {
      case 'appointment_created':
        icon = Icons.calendar_today;
        color = Colors.blue;
      case 'appointment_confirmed':
        icon = Icons.check_circle;
        color = Colors.green;
      case 'appointment_cancelled':
        icon = Icons.cancel;
        color = Colors.red;
      case 'appointment_completed':
        icon = Icons.done_all;
        color = Colors.teal;
      case 'appointment_reminder':
        icon = Icons.alarm;
        color = Colors.orange;
      case 'waitlist_slot_available':
        icon = Icons.celebration;
        color = Colors.purple;
      default:
        icon = Icons.notifications_active;
        color = AppColors.getPrimary(context);
    }

    return Icon(icon, color: color, size: 22);
  }
}
