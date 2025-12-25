import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/data_booking.dart';
import 'package:flutter/material.dart';

class AppointmentViewBody extends StatelessWidget {
  const AppointmentViewBody({
    super.key,
    required this.doctor,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  final Doctor doctor;
  final ValueChanged<DateTime> onDateSelected;
  final void Function(String? time, int? scheduleId) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomAppBar(
              title: 'حجز موعد',
              isBackButtonVisible: true,
              isUserImageVisible: false,
              isHeartIconVisible: false,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DataBooking(
              doctor: doctor,
              onDateSelected: onDateSelected,
              onTimeSelected: (time, scheduleId) =>
                  onTimeSelected(time, scheduleId),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
