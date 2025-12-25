import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details/details_view_actions.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/details_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.doctorId});
  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<ReviewCubit>(),
      child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
        builder: (context, state) {
          Doctor? loadedDoctor;
          if (state is DoctorDetailsLoaded) {
            loadedDoctor = state.doctor;
          }

          return Scaffold(
            body: SafeArea(child: DetailsViewBody(doctorId: doctorId)),
            bottomNavigationBar: loadedDoctor != null
                ? DetailsViewActions(doctor: loadedDoctor)
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
