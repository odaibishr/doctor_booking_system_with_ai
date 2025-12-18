import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/widgets/data_booking.dart';
import 'package:flutter/material.dart';

class AppointmentViewBody extends StatelessWidget {
  const AppointmentViewBody({
    super.key,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<String> onTimeSelected;

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
              onDateSelected: onDateSelected,
              onTimeSelected: onTimeSelected,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

