import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/presention/favorite_doctor_list_view.dart';
import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/presention/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDoctorBody extends StatefulWidget {
  const FavoriteDoctorBody({super.key});

  @override
  State<FavoriteDoctorBody> createState() => _FavoriteDoctorBodyState();
}

class _FavoriteDoctorBodyState extends State<FavoriteDoctorBody> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<FavoriteDoctorCubit>().getFavoriteDoctors();
  }

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
                  return const CustomLoader(loaderSize: kLoaderSize);
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
