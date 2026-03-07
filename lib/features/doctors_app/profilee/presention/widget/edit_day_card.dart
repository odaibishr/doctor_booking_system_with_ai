import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/editable_day_data.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/time_field.dart';
import 'package:flutter/material.dart';

class EditDayCard extends StatelessWidget {
  final EditableDayData data;
  final ValueChanged<bool> onToggle;
  final ValueChanged<TimeOfDay> onStartTimeChanged;
  final ValueChanged<TimeOfDay> onEndTimeChanged;

  const EditDayCard({
    super.key,
    required this.data,
    required this.onToggle,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.gray300Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                size: 20,
                color: data.isActive
                    ? context.primaryColor
                    : context.gray300Color,
              ),
              const SizedBox(width: 8),
              Text(
                data.dayName,
                style: FontStyles.subTitle2.copyWith(
                  fontWeight: FontWeight.w700,
                  color: data.isActive
                      ? context.textPrimaryColor
                      : context.gray400Color,
                ),
              ),
              const Spacer(),
              Switch.adaptive(
                value: data.isActive,
                activeTrackColor: context.gray200Color,
                activeThumbColor: context.primaryColor,
                onChanged: onToggle,
                inactiveTrackColor: context.gray200Color,
                inactiveThumbColor: context.gray400Color,
                trackOutlineColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
              ),
            ],
          ),
          if (data.isActive) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TimeField(
                    label: 'من',
                    time: data.startTime,
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: data.startTime,
                      );
                      if (picked != null) onStartTimeChanged(picked);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TimeField(
                    label: 'إلى',
                    time: data.endTime,
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: data.endTime,
                      );
                      if (picked != null) onEndTimeChanged(picked);
                    },
                  ),
                ),
              ],
            ),
          ],
          if (!data.isActive)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'مغلق - يوم عطلة',
                style: FontStyles.body2.copyWith(color: context.gray400Color),
              ),
            ),
        ],
      ),
    );
  }
}
