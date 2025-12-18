import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/appointment_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  void _onDateSelected(DateTime date) {
    setState(() => _selectedDate = date);
  }

  void _onTimeSelected(String time) {
    setState(() => _selectedTime = time);
  }

  String _formatSelection() {
    final date = DateFormat.yMMMMEEEEd('ar').format(_selectedDate);
    final time = _selectedTime ?? '';
    if (time.isEmpty) return date;
    return '$date • $time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppointmentViewBody(
          onDateSelected: _onDateSelected,
          onTimeSelected: _onTimeSelected,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
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
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.event_available,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الموعد المختار',
                            style: FontStyles.body1.copyWith(
                              color: AppColors.gray600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            (_selectedTime ?? '').isEmpty
                                ? 'اختر الوقت للمتابعة'
                                : _formatSelection(),
                            style: FontStyles.subTitle3.copyWith(
                              color: AppColors.black,
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
              MainButton(
                text: 'متابعة الدفع',
                onTap: () {
                  if ((_selectedTime ?? '').isEmpty) {
                    context.showErrorToast('يرجى اختيار وقت مناسب أولاً');
                    return;
                  }
                  GoRouter.of(context).push(AppRouter.paymentViewRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

