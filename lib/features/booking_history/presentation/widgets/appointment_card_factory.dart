import 'package:doctor_booking_system_with_ai/core/notifications/notification_extensions.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/main_button.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/review_dialog.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'appointment_card.dart';

class AppointmentCardFactory {
  static List<Widget> getButtons({
    required BuildContext context,
    required AppointmentStatus status,
    required Booking booking,
  }) {
    switch (status) {
      case AppointmentStatus.upcoming:
        return [
          Expanded(
            child: MainButton(
              text: 'تغيير الموعد',
              onTap: () => _showRescheduleBottomSheet(context, booking),
              height: 28,
              radius: 6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: 'إلغاء الموعد',
              onTap: () => _showCancelBottomSheet(context, booking.id),
              height: 28,
              radius: 6,
              color: context.gray300Color,
            ),
          ),
        ];

      case AppointmentStatus.completed:
        return [
          Expanded(
            child: MainButton(
              text: 'حجز مرة أخرى',
              onTap: () {
                GoRouter.of(
                  context,
                ).push(AppRouter.detailsViewRoute, extra: booking.doctorId);
              },
              height: 28,
              radius: 6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: 'أضف تقييماً',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  builder: (context) =>
                      ReviewDialog(doctorId: booking.doctorId),
                );
              },
              height: 28,
              radius: 6,
              color: context.gray300Color,
            ),
          ),
        ];

      case AppointmentStatus.cancelled:
        return [
          Expanded(
            child: MainButton(
              text: 'إعادة الحجز',
              onTap: () {
                GoRouter.of(
                  context,
                ).push(AppRouter.detailsViewRoute, extra: booking.doctorId);
              },
              height: 28,
              radius: 6,
              color: context.primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MainButton(
              text: 'حجز جديد',
              onTap: () {
                GoRouter.of(
                  context,
                ).push(AppRouter.detailsViewRoute, extra: booking.doctorId);
              },
              height: 28,
              radius: 6,
              color: context.gray300Color,
            ),
          ),
        ];
    }
  }

  static void _showRescheduleBottomSheet(
    BuildContext context,
    Booking booking,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (bottomSheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              right: 20,
              left: 20,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'تغيير الموعد',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'سيتم نقلك لصفحة تعديل الموعد مع د. ${booking.doctor.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.gray600Color),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    text: 'تعديل الموعد',
                    onTap: () async {
                      Navigator.pop(bottomSheetContext);
                      final result = await GoRouter.of(context).push<bool>(
                        AppRouter.rescheduleAppointmentViewRoute,
                        extra: booking,
                      );
                      if (result == true && context.mounted) {
                        context
                            .read<BookingHistoryCubit>()
                            .fetchBookingHistory();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    text: 'إلغاء',
                    onTap: () => Navigator.pop(bottomSheetContext),
                    color: context.gray300Color,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _showCancelBottomSheet(BuildContext context, int bookingId) {
    final TextEditingController reasonController = TextEditingController();
    final cubit = context.read<BookingHistoryCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (bottomSheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
              right: 20,
              left: 20,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'إلغاء الموعد',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(bottomSheetContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(color: AppColors.gray300),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'من فضلك اكتب سبب الإلغاء',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'هذا يساعدنا على تحسين تجربتك في المرات القادمة',
                        style: TextStyle(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  cursorColor: AppColors.gray500,
                  decoration: InputDecoration(
                    hintText: 'اكتب سبب الإلغاء...',
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.gray200),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A8C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final reason = reasonController.text.trim();
                      if (reason.isEmpty) {
                        context.showErrorToast(
                          'من فضلك اكتب سبب الإلغاء أولاً',
                        );
                      } else {
                        Navigator.pop(bottomSheetContext);
                        cubit.cancelAppointment(bookingId, reason);
                      }
                    },
                    child: const Text(
                      'إرسال',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
