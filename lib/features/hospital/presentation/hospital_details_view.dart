import 'package:doctor_booking_system_with_ai/features/hospital/presentation/manager/hospital_detailes/hospital_detailes_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_details_view_body.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalDetailsView extends StatelessWidget {
  const HospitalDetailsView({super.key, required this.hospitalId});
  final int hospitalId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HospitalDetailesCubit>(),
      child: Scaffold(
        body: SafeArea(child: HospitalDetailsViewBody(hospitalId: hospitalId)),
      ),
    );
  }
}
