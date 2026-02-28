import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/profile/doctor_schedule_state.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorScheduleView extends StatelessWidget {
  const DoctorScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<DoctorScheduleCubit>()..fetchAll(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomAppBar(
                title: 'جدول المواعيد',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
            ),
          ),
        ),
        body: BlocConsumer<DoctorScheduleCubit, DoctorScheduleState>(
          listener: (context, state) {
            if (state is DoctorScheduleError) {
              context.showErrorToast(state.message);
            }
          },
          builder: (context, state) {
            if (state is DoctorScheduleLoading) {
              return const Center(child: CustomLoader(loaderSize: kLoaderSize));
            }

            if (state is DoctorScheduleLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      context,
                      'أيام الدوام',
                      Icons.calendar_today_rounded,
                    ),
                    const SizedBox(height: 12),
                    ...state.schedules.map((schedule) {
                      return _ScheduleCard(
                        dayName:
                            schedule.day?.dayName ?? 'يوم ${schedule.dayId}',
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        onEdit: () => _showEditTimeDialog(
                          context,
                          schedule.id,
                          schedule.startTime,
                          schedule.endTime,
                        ),
                      );
                    }),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        _sectionTitle(
                          context,
                          'أيام الإجازة',
                          Icons.beach_access_rounded,
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => _showAddDayOffSheet(context, state),
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          label: Text(
                            'إضافة',
                            style: FontStyles.body3.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (state.daysOff.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.getGray100(context),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.event_available,
                              size: 40,
                              color: context.gray400Color,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'لا توجد أيام إجازة',
                              style: FontStyles.body2.copyWith(
                                color: context.gray500Color,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ...state.daysOff.map((dayOff) {
                        return _DayOffCard(
                          dayName: dayOff.day?.dayName ?? 'يوم ${dayOff.dayId}',
                          onDelete: () {
                            context.read<DoctorScheduleCubit>().removeDayOff(
                              dayOff.id,
                            );
                          },
                        );
                      }),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: FontStyles.subTitle1.copyWith(
            fontWeight: FontWeight.w600,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }

  void _showEditTimeDialog(
    BuildContext context,
    int scheduleId,
    String currentStart,
    String currentEnd,
  ) {
    TimeOfDay startTime = _parseTime(currentStart);
    TimeOfDay endTime = _parseTime(currentEnd);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(
                'تعديل الوقت',
                style: FontStyles.subTitle1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('وقت البدء'),
                    trailing: Text(
                      _formatTime(startTime),
                      style: FontStyles.subTitle2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: ctx,
                        initialTime: startTime,
                      );
                      if (picked != null)
                        setDialogState(() => startTime = picked);
                    },
                  ),
                  ListTile(
                    title: const Text('وقت الانتهاء'),
                    trailing: Text(
                      _formatTime(endTime),
                      style: FontStyles.subTitle2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: ctx,
                        initialTime: endTime,
                      );
                      if (picked != null)
                        setDialogState(() => endTime = picked);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('إلغاء'),
                ),
                FilledButton(
                  onPressed: () {
                    context.read<DoctorScheduleCubit>().updateScheduleTime(
                      scheduleId,
                      _formatTime(startTime),
                      _formatTime(endTime),
                    );
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddDayOffSheet(BuildContext context, DoctorScheduleLoaded state) {
    final existingDayIds = state.daysOff.map((d) => d.dayId).toSet();
    final List<Map<String, dynamic>> allDays = [
      {'id': 1, 'name': 'السبت'},
      {'id': 2, 'name': 'الأحد'},
      {'id': 3, 'name': 'الإثنين'},
      {'id': 4, 'name': 'الثلاثاء'},
      {'id': 5, 'name': 'الأربعاء'},
      {'id': 6, 'name': 'الخميس'},
      {'id': 7, 'name': 'الجمعة'},
    ];

    final available = allDays
        .where((d) => !existingDayIds.contains(d['id']))
        .toList();
    if (available.isEmpty) {
      context.showErrorToast('جميع الأيام مضافة بالفعل');
      return;
    }

    final selectedIds = <int>{};

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اختر أيام الإجازة',
                    style: FontStyles.subTitle1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: available.map((day) {
                      final isSelected = selectedIds.contains(day['id']);
                      return FilterChip(
                        label: Text(day['name'] as String),
                        selected: isSelected,
                        selectedColor: AppColors.primary.withValues(alpha: 0.2),
                        checkmarkColor: AppColors.primary,
                        onSelected: (val) {
                          setSheetState(() {
                            if (val) {
                              selectedIds.add(day['id'] as int);
                            } else {
                              selectedIds.remove(day['id'] as int);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: selectedIds.isEmpty
                          ? null
                          : () {
                              context.read<DoctorScheduleCubit>().addDayOff(
                                selectedIds.toList(),
                              );
                              Navigator.pop(sheetContext);
                            },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('إضافة'),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
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
}

class _ScheduleCard extends StatelessWidget {
  final String dayName;
  final String startTime;
  final String endTime;
  final VoidCallback onEdit;

  const _ScheduleCard({
    required this.dayName,
    required this.startTime,
    required this.endTime,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.schedule,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: FontStyles.subTitle2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$startTime - $endTime',
                  style: FontStyles.body3.copyWith(color: context.gray500Color),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayOffCard extends StatelessWidget {
  final String dayName;
  final VoidCallback onDelete;

  const _DayOffCard({required this.dayName, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.beach_access_rounded,
              color: AppColors.error,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              dayName,
              style: FontStyles.subTitle2.copyWith(
                fontWeight: FontWeight.w600,
                color: context.blackColor,
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 20,
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.error.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}
