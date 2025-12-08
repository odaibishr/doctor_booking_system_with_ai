import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalDetailsDoctorsTab extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;

  const HospitalDetailsDoctorsTab({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorsLoaded) {
          final doctors = state.doctors;
          return ListView.separated(
            itemCount: doctors.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return DoctorCardHorizontail(doctor: doctors[index]);
            },
          );
        } else if (state is DoctorsError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
