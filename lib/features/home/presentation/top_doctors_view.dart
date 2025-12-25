import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/doctor_card_horizontail.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_doctor_skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopDoctorsView extends StatelessWidget {
  const TopDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CustomAppBar(
                title: 'أفضل الأطباء',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorsLoading) {
                      return const SearchDoctorSkelton();
                    } else if (state is DoctorsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: FontStyles.body1.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      );
                    } else if (state is DoctorsLoaded) {
                      final topDoctors = state.doctors
                          .where((doctor) => doctor.isTopDoctor == 1)
                          .toList();

                      if (topDoctors.isEmpty) {
                        return Center(
                          child: Text(
                            'لا يوجد أطباء متاحون حالياً',
                            style: FontStyles.body1.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: topDoctors.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return DoctorCardHorizontail(
                            doctor: topDoctors[index],
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
