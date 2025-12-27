import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/animated_widgets.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';

class BookingCardsListView extends StatelessWidget {
  const BookingCardsListView({
    super.key,
    required this.bookings,
    required this.status,
  });

  final List<Booking> bookings;
  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return AnimatedEntrance(
        animationType: AnimationType.fadeScale,
        child: Center(
          child: Text(
            'لا توجد حجوزات في هذا القسم حالياً',
            style: TextStyle(color: context.gray600Color),
          ),
        ),
      );
    }

    if (!Responsive.isMobile(context)) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
          mainAxisExtent: 190,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
        ),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            delay: const Duration(milliseconds: 60),
            animationType: AnimationType.fadeScale,
            child: AppointmentCard(booking: bookings[index], status: status),
          );
        },
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: bookings.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          delay: const Duration(milliseconds: 80),
          animationType: AnimationType.fadeSlideUp,
          child: AppointmentCard(booking: bookings[index], status: status),
        );
      },
    );
  }
}
