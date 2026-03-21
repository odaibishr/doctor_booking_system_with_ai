import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/appointment_action_buttons.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/appointment_date_time_row.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/appointment_info_box.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/patient_info_section.dart';
import 'package:flutter/material.dart';

enum AppointmentCardType { upcoming, confirmed, previous, cancelled }

class DAppointmentCard extends StatelessWidget {
  const DAppointmentCard({
    super.key,
    this.patientName = '',
    this.patientImage = '',
    this.time = '',
    this.date = '',
    this.bookingNumber = '',
    this.isNew = false,
    this.cardType = AppointmentCardType.upcoming,
    this.onConfirm,
    this.onReject,
    this.cancellationDate,
    this.cancellationReason,
  });

  final String patientName;
  final String patientImage;
  final String time;
  final String date;
  final String bookingNumber;
  final bool isNew;
  final AppointmentCardType cardType;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final String? cancellationDate;
  final String? cancellationReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: context.gray100Color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.getGray200(context), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PatientInfoSection(
            patientName: patientName,
            patientImage: patientImage,
            bookingNumber: bookingNumber,
            isNew: isNew && cardType == AppointmentCardType.upcoming,
            isCancelled: cardType == AppointmentCardType.cancelled,
            isCompleted: cardType == AppointmentCardType.previous,
            isConfirmed: cardType == AppointmentCardType.confirmed,
          ),
          const SizedBox(height: 14),
          if (cardType == AppointmentCardType.upcoming) ...[
            AppointmentDateTimeRow(date: date, time: time),
            const SizedBox(height: 14),
            AppointmentActionButtons(
              onConfirm: onConfirm ?? () {},
              onReject: onReject ?? () {},
            ),
          ] else if (cardType == AppointmentCardType.previous ||
              cardType == AppointmentCardType.confirmed) ...[
            _buildPreviousContent(context),
          ] else if (cardType == AppointmentCardType.cancelled) ...[
            _buildCancelledContent(context),
          ],
        ],
      ),
    );
  }

  Widget _buildPreviousContent(BuildContext context) {
    return _buildDateTimeGrid(context);
  }

  Widget _buildCancelledContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (cancellationReason != null && cancellationReason!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color: context.textTertiaryColor,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'سبب الإلغاء',
                              style: TextStyle(
                                color: context.textTertiaryColor,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cancellationDate != null) ...[
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: context.textTertiaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'تم الإلغاء في $cancellationDate',
                            style: TextStyle(
                              color: context.textTertiaryColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 4),
                Text(
                  cancellationReason!,
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        _buildDateTimeGrid(context),
      ],
    );
  }

  Widget _buildDateTimeGrid(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: AppointmentInfoBox(
            label: 'التاريخ',
            value: date,
            icon: Icons.calendar_today_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppointmentInfoBox(
            label: 'الوقت',
            value: time,
            icon: Icons.access_time_outlined,
          ),
        ),
      ],
    );
  }
}
