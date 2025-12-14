import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/widgets/booking_history_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingHistoryView extends StatelessWidget {
  const BookingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<BookingHistoryCubit>()..fetchBookingHistory(),
      child: Scaffold(
        body: SafeArea(child: const BookingHistoryViewBody()),
      ),
    );
  }
}
