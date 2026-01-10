import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/date_picker_card.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_period_selector.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/time_slot_selector.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RescheduleAppointmentView extends StatefulWidget {
  final Booking booking;

  const RescheduleAppointmentView({super.key, required this.booking});

  @override
  State<RescheduleAppointmentView> createState() =>
      _RescheduleAppointmentViewState();
}

class _RescheduleAppointmentViewState extends State<RescheduleAppointmentView> {
  late DateTime _selectedDate;
  String? _selectedPeriodKey;
  String? _selectedTimeSlot;
  int? _selectedScheduleId;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedTimeSlot = null;
      _selectedPeriodKey = null;
      _selectedScheduleId = null;
    });
  }

  void _handlePeriodSelected(String periodKey) {
    setState(() {
      _selectedPeriodKey = periodKey;
      final slots = _timeSlotsForPeriod(periodKey);
      if (slots.isNotEmpty) {
        _selectedTimeSlot = slots.first;
        final schedule = _getCurrentSchedule();
        _selectedScheduleId = schedule?.id;
      } else {
        _selectedTimeSlot = null;
        _selectedScheduleId = null;
      }
    });
  }

  void _handleTimeSelected(String timeSlot) {
    setState(() {
      _selectedTimeSlot = timeSlot;
      final schedule = _getCurrentSchedule();
      _selectedScheduleId = schedule?.id;
    });
  }

  DoctorSchedule? _getCurrentSchedule() {
    final schedules = widget.booking.doctor.schedules;
    if (schedules == null || schedules.isEmpty) return null;

    int targetDayNumber = _getDayNumber(_selectedDate.weekday);

    return schedules.firstWhere(
      (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      orElse: () => schedules.first,
    );
  }

  int _getDayNumber(int weekday) {
    switch (weekday) {
      case DateTime.saturday:
        return 1;
      case DateTime.sunday:
        return 2;
      case DateTime.monday:
        return 3;
      case DateTime.tuesday:
        return 4;
      case DateTime.wednesday:
        return 5;
      case DateTime.thursday:
        return 6;
      case DateTime.friday:
        return 7;
      default:
        return 1;
    }
  }

  List<String> _timeSlotsForPeriod(String? periodKey) {
    final schedules = widget.booking.doctor.schedules;
    if (schedules == null || schedules.isEmpty) return [];

    int targetDayNumber = _getDayNumber(_selectedDate.weekday);

    final schedule = schedules.firstWhere(
      (s) => (s.day?.dayNumber ?? s.dayId) == targetDayNumber,
      orElse: () => schedules.first,
    );

    final startTime = schedule.startTime;
    final endTime = schedule.endTime;

    final List<String> slots = [];
    final start = int.parse(startTime.split(':')[0]);
    final end = int.parse(endTime.split(':')[0]);

    for (int h = start; h < end; h++) {
      final hourStr = h > 12 ? (h - 12).toString() : h.toString();
      final suffix = h >= 12 ? 'م' : 'ص';
      slots.add('$hourStr:00 $suffix');
      slots.add('$hourStr:30 $suffix');
    }

    if (periodKey == 'morning') {
      return slots.where((s) => s.contains('ص') || s.startsWith('12')).toList();
    } else if (periodKey == 'evening') {
      return slots
          .where((s) => s.contains('م') && !s.startsWith('12'))
          .toList();
    }

    return slots;
  }

  String _formatSelection() {
    final date = DateFormat.yMMMMEEEEd('ar').format(_selectedDate);
    final time = _selectedTimeSlot ?? '';
    if (time.isEmpty) return date;
    return '$date • $time';
  }

  void _onReschedule() {
    if (_selectedTimeSlot == null || _selectedTimeSlot!.isEmpty) {
      context.showErrorToast('يرجى اختيار وقت مناسب أولاً');
      return;
    }

    final dateStr = DateFormat('yyyy-MM-dd', 'en').format(_selectedDate);
    context.read<BookingHistoryCubit>().rescheduleAppointment(
      widget.booking.id,
      dateStr,
      _selectedScheduleId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasSchedules = widget.booking.doctor.schedules?.isNotEmpty ?? false;

    return BlocListener<BookingHistoryCubit, BookingHistoryState>(
      listener: (context, state) {
        if (state is RescheduleAppointmentSuccess) {
          context.showSuccessToast('تم تعديل الموعد بنجاح');
          GoRouter.of(context).pop(true);
        } else if (state is RescheduleAppointmentError) {
          context.showErrorToast(state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: CustomAppBar(
                    title: 'تعديل الموعد',
                    isBackButtonVisible: true,
                    isUserImageVisible: false,
                    isHeartIconVisible: false,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تعديل موعدك مع د. ${widget.booking.doctor.name}',
                        style: FontStyles.subTitle3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'الموعد الحالي: ${widget.booking.date}',
                        style: FontStyles.body1.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (!hasSchedules)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'لا تتوفر مواعيد حالياً لهذا الطبيب',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      else ...[
                        DatePickerCard(
                          selectedDate: _selectedDate,
                          onDateSelected: _handleDateSelected,
                          doctorSchedules: widget.booking.doctor.schedules,
                        ),
                        const SizedBox(height: 16),
                        TimePeriodSelector(
                          selectedPeriodKey: _selectedPeriodKey,
                          onPeriodSelected: _handlePeriodSelected,
                        ),
                        const SizedBox(height: 16),
                        TimeSlotSelector(
                          slots: _timeSlotsForPeriod(_selectedPeriodKey),
                          selectedSlot: _selectedTimeSlot,
                          onSelected: _handleTimeSelected,
                          disabledSlots: const {},
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
        bottomNavigationBar: hasSchedules
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 14,
                      offset: const Offset(0, -6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.gray200),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: context.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.event_available,
                                color: context.primaryColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الموعد الجديد',
                                    style: FontStyles.body1.copyWith(
                                      color: AppColors.gray600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    (_selectedTimeSlot ?? '').isEmpty
                                        ? 'اختر الوقت للمتابعة'
                                        : _formatSelection(),
                                    style: FontStyles.subTitle3.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<BookingHistoryCubit, BookingHistoryState>(
                        builder: (context, state) {
                          final isLoading =
                              state is RescheduleAppointmentLoading;
                          return MainButton(
                            text: isLoading
                                ? 'جاري التعديل...'
                                : 'تأكيد تعديل الموعد',
                            onTap: isLoading ? () {} : _onReschedule,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
