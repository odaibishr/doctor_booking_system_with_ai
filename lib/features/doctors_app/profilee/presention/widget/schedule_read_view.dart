import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/read_day_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/summary_card.dart';
import 'package:flutter/material.dart';

class ScheduleReadView extends StatelessWidget {
  final DoctorScheduleLoaded state;

  const ScheduleReadView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final dayOffIds = state.daysOff.map((d) => d.dayId).toSet();
    final totalHours = _calcTotalHours(state.schedules, dayOffIds);
    final activeCount =
        state.schedules.length -
        state.daysOff
            .where((d) => state.schedules.any((s) => s.dayId == d.dayId))
            .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: SummaryCard(
                  icon: Icons.calendar_month_rounded,
                  label: 'أيام العمل النشطة',
                  value: '$activeCount أيام',
                  color: context.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  icon: Icons.access_time_rounded,
                  label: 'ساعات العمل',
                  value: '$totalHours ساعة',
                  color: context.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'تفاصيل الجدول الأسبوعي',
                style: FontStyles.subTitle1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(7, (i) {
            final dayId = i + 1;
            final schedule = state.schedules.cast<DoctorSchedule?>().firstWhere(
              (s) => s!.dayId == dayId,
              orElse: () => null,
            );
            final isDayOff = dayOffIds.contains(dayId);
            final dayName = schedule?.day?.dayName ?? dayNameById(dayId);

            return ReadDayCard(
              dayName: dayName,
              isDayOff: isDayOff || schedule == null,
              startTime: schedule?.startTime,
              endTime: schedule?.endTime,
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  int _calcTotalHours(List<DoctorSchedule> schedules, Set<int> dayOffIds) {
    int total = 0;
    for (final s in schedules) {
      if (dayOffIds.contains(s.dayId)) continue;
      final start = _parseTimeStr(s.startTime);
      final end = _parseTimeStr(s.endTime);
      int diff =
          (end.hour * 60 + end.minute) - (start.hour * 60 + start.minute);
      if (diff < 0) diff += 24 * 60;
      total += diff;
    }
    return (total / 60).round();
  }

  TimeOfDay _parseTimeStr(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}
