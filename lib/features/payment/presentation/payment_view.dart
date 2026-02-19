import 'dart:ui';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_view_body.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class PaymentView extends StatefulWidget {
  final Doctor doctor;
  final DateTime date;
  final String time;
  final int? doctorScheduleId;

  const PaymentView({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    this.doctorScheduleId,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool completePayment = false;
  void showBottomSheetNow() {
    setState(() {
      completePayment = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<PaymentCubit>(),
      child: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) {
          developer.log('PaymentState updated: $state', name: 'PaymentView');
          if (state is PaymentFailure) {
            developer.log(
              'Payment Error: ${state.errMessage}',
              name: 'PaymentView',
              level: 1000,
            );
          } else if (state is PaymentSuccess) {
            developer.log(
              'Payment Success! Transaction ID: ${state.transactionId}',
              name: 'PaymentView',
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: PaymentViewBody(
                    completePayment: completePayment,
                    doctor: widget.doctor,
                    date: widget.date,
                    time: widget.time,
                    doctorScheduleId: widget.doctorScheduleId,
                    onpres: showBottomSheetNow,
                  ),
                ),
                if (completePayment == true)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {},
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                if (completePayment == true)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: PaymentBottomSheet(
                      doctorName: widget.doctor.name,
                      userName: HiveService.getCachedAuthData()?.name ?? '',
                      date: DateFormat.yMMMMd('ar').format(widget.date),
                      time: widget.time,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
