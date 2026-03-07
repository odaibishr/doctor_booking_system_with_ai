import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/parse_helpers.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/bottom_actions.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/edit_day_card.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/profilee/presention/widget/editable_day_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScheduleView extends StatefulWidget {
  final DoctorScheduleLoaded initialState;
  const EditScheduleView({super.key, required this.initialState});

  @override
  State<EditScheduleView> createState() => _EditScheduleViewState();
}

class _EditScheduleViewState extends State<EditScheduleView> {
  late final Map<int, EditableDayData> _days;
  bool _showAllDays = false;

  @override
  void initState() {
    super.initState();
    _days = {};
    final dayOffIds = widget.initialState.daysOff.map((d) => d.dayId).toSet();

    for (int i = 1; i <= 7; i++) {
      final schedule = widget.initialState.schedules
          .cast<DoctorSchedule?>()
          .firstWhere((s) => s!.dayId == i, orElse: () => null);
      final isDayOff = dayOffIds.contains(i);

      _days[i] = EditableDayData(
        dayId: i,
        dayName: schedule?.day?.dayName ?? dayNameById(i),
        isActive: schedule != null && !isDayOff,
        scheduleId: schedule?.id,
        startTime: schedule != null
            ? _parseTime(schedule.startTime)
            : const TimeOfDay(hour: 9, minute: 0),
        endTime: schedule != null
            ? _parseTime(schedule.endTime)
            : const TimeOfDay(hour: 17, minute: 0),
        dayOffId: isDayOff
            ? widget.initialState.daysOff.firstWhere((d) => d.dayId == i).id
            : null,
        wasOriginallyDayOff: isDayOff,
        hadSchedule: schedule != null,
      );
    }
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final activeDays = _days.values.where((d) => d.isActive).toList();
    final inactiveDays = _days.values.where((d) => !d.isActive).toList();
    final visibleDays = [...activeDays, if (_showAllDays) ...inactiveDays];
    visibleDays.sort((a, b) => a.dayId.compareTo(b.dayId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomAppBar(
              title: 'تعديل المواعيد',
              isBackButtonVisible: true,
              isUserImageVisible: false,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: context.primaryColor.withValues(alpha: 0.08),
            alignment: Alignment.centerRight,
            child: Text(
              'قم بتحديد أيام العمل وساعات المداولة للعيادة',
              textAlign: TextAlign.center,
              style: FontStyles.body1.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  ...visibleDays.map(
                    (day) => EditDayCard(
                      data: day,
                      onToggle: (val) {
                        setState(() => day.isActive = val);
                      },
                      onStartTimeChanged: (time) {
                        setState(() => day.startTime = time);
                      },
                      onEndTimeChanged: (time) {
                        setState(() => day.endTime = time);
                      },
                    ),
                  ),
                  if (!_showAllDays && inactiveDays.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => setState(() => _showAllDays = true),
                          style: FilledButton.styleFrom(
                            backgroundColor: context.gray200Color,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            '+ إظهار باقي أيام الأسبوع',
                            style: FontStyles.subTitle3.copyWith(
                              color: context.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: context.gray400Color,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'سيتم تحديث المواعيد فوراً لجميع المرضى المسجلين.',
                          style: FontStyles.body3.copyWith(
                            color: context.gray500Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          BottomActions(
            onSave: () => _saveChanges(context),
            onCancel: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _saveChanges(BuildContext context) {
    final cubit = context.read<DoctorScheduleCubit>();

    final changes = _days.values.map((day) {
      return ScheduleDayChange(
        dayId: day.dayId,
        isActive: day.isActive,
        scheduleId: day.scheduleId,
        startTime: _formatTime(day.startTime),
        endTime: _formatTime(day.endTime),
        dayOffId: day.dayOffId,
        wasOriginallyDayOff: day.wasOriginallyDayOff,
        hadSchedule: day.hadSchedule,
      );
    }).toList();

    Navigator.pop(context);
    cubit.saveScheduleChanges(changes);
  }
}
