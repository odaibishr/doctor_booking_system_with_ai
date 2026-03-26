import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/utils/responsive.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/doctor_card_skeleton.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/hospital_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HopitalsListView extends StatefulWidget {
  const HopitalsListView({super.key});

  @override
  State<HopitalsListView> createState() => _HopitalsListViewState();
}

class _HopitalsListViewState extends State<HopitalsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalCubit, HospitalState>(
      builder: (context, state) {
        if (state is HospitalLoadded) {
          final hospitals = state.hospitals.take(5).toList();
          final isDesktop = Responsive.isDesktop(context);
          return SizedBox(
            height: isDesktop ? 240 : 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: HospitalCard(
                    hospital: hospitals[index],
                    width: isDesktop ? 280 : 221,
                    height: isDesktop ? 230 : 180,
                  ),
                );
              },
            ),
          );
        }
        if (state is HospitalError) {
          return Center(
            child: Text(
              state.message,
              style: FontStyles.body1.copyWith(color: AppColors.gray600),
            ),
          );
        } else {
          return SizedBox(
            height: Responsive.isDesktop(context) ? 240 : 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => const DoctorCardSkeleton(),
            ),
          );
        }
      },
    );
  }
}
