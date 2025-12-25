import 'dart:ui';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/widget/payment_view_body.dart';
import 'package:svg_flutter/svg.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/manager/payment_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    top: MediaQuery.of(context).size.height * 0.49,
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.002,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: PaymentBottomSheet(),
                    ),
                  ),
                if (completePayment == true)
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.37,
                    bottom: MediaQuery.of(context).size.height * 0.43,
                    child: SvgPicture.asset('assets/images/sucess.svg'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
