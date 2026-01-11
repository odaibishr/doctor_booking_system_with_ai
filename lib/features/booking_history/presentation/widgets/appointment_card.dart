import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card_factory.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_doctor_info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

enum AppointmentStatus { upcoming, completed, cancelled }

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.booking,
    required this.status,
  });

  final Booking booking;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push(AppRouter.detailsViewRoute, extra: booking.doctorId);
      },
      child: Container(
        height: 170,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.cardBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
              child: AppointmentDoctorInfo(
                doctorName: _doctorName(),
                location: _resolveLocation(),
                date: _formatDate(),
                bookingNumber: _bookingNumber(),
                doctorImage: _doctorImageUrl(),
                isReturning: booking.isReturning,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppointmentCardFactory.getButtons(
                context: context,
                status: status,
                booking: booking,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate() {
    if (booking.date.isEmpty) return '';

    try {
      final parsedDate = DateTime.parse(booking.date);
      final datePart = DateFormat('dd MMM yyyy').format(parsedDate);
      final start = _formatTime(booking.schedule.startTime);
      final end = _formatTime(booking.schedule.endTime);

      if (start.isNotEmpty && end.isNotEmpty) {
        return '$datePart - $start إلى $end';
      } else if (start.isNotEmpty) {
        return '$datePart - $start';
      }

      return datePart;
    } catch (_) {
      return booking.date;
    }
  }

  String _formatTime(String value) {
    if (value.isEmpty) return '';

    final parts = value.split(':');
    if (parts.length >= 2) {
      return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    }

    return value;
  }

  String _bookingNumber() {
    final reference = booking.transaction.id != 0
        ? booking.transaction.id
        : booking.id;

    return 'رقم الحجز: $reference';
  }

  String _doctorName() {
    if (booking.doctor.name.isEmpty) return '—';
    return 'د. ${booking.doctor.name}';
  }

  String _resolveLocation() {
    if (booking.doctor.hospital.name.isNotEmpty) {
      return booking.doctor.hospital.name;
    }

    final cachedHospital = _getHospitalFromCache(booking.doctor.hospitalId);
    if (cachedHospital?.name.isNotEmpty == true) {
      return cachedHospital!.name;
    }

    if (booking.doctor.location.name.isNotEmpty) {
      return booking.doctor.location.name;
    }

    return 'غير متوفر';
  }

  Hospital? _getHospitalFromCache(int id) {
    if (id == 0) return null;

    try {
      final box = Hive.box<Hospital>(kHospitalBox);
      return box.get(id);
    } catch (_) {
      return null;
    }
  }

  String _doctorImageUrl() {
    if (booking.doctor.profileImage.isEmpty) return '';

    if (booking.doctor.profileImage.startsWith('http')) {
      return booking.doctor.profileImage;
    }

    return '${EndPoints.photoUrl}/${booking.doctor.profileImage}';
  }
}
