import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/favorite_doctor_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/widgets/favorite_doctors_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDoctorBody extends StatefulWidget {
  const FavoriteDoctorBody({super.key});

  @override
  State<FavoriteDoctorBody> createState() => _FavoriteDoctorBodyState();
}

class _FavoriteDoctorBodyState extends State<FavoriteDoctorBody> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteDoctorCubit>().getFavoriteDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          CustomAppBar(
            title: 'المفضلة',
            isBackButtonVisible: true,
            isUserImageVisible: false,
          ),
          SizedBox(height: 30),
          Expanded(
            child: BlocBuilder<FavoriteDoctorCubit, FavoriteDoctorState>(
              builder: (context, state) {
                if (state is FavoirteDoctorsLoading) {
                  return const FavoriteDoctorsSkeleton();
                } else if (state is FavoriteDoctorsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: FontStyles.body1.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  );
                } else if (state is FavoriteDoctorsLoaded) {
                  final doctors = state.doctors;
                  return FavoriteDoctorListView(doctors: doctors);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
