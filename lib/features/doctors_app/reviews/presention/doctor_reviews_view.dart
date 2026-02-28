import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/patient_review.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/reviews/doctor_reviews_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/reviews/doctor_reviews_state.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorReviewsView extends StatelessWidget {
  const DoctorReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<DoctorReviewsCubit>()..fetchMyReviews(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: CustomAppBar(
                title: 'المراجعات',
                isBackButtonVisible: true,
                isUserImageVisible: false,
              ),
            ),
          ),
        ),
        body: BlocBuilder<DoctorReviewsCubit, DoctorReviewsState>(
          builder: (context, state) {
            if (state is DoctorReviewsLoading) {
              return const Center(child: CustomLoader(loaderSize: kLoaderSize));
            }

            if (state is DoctorReviewsError) {
              return Center(child: Text(state.message));
            }

            if (state is DoctorReviewsLoaded) {
              final reviews = state.reviews;
              if (reviews.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد مراجعات حتى الآن',
                    style: TextStyle(color: AppColors.gray600),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                itemCount: reviews.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 32, color: AppColors.gray200),
                itemBuilder: (context, index) {
                  final reviewItem = reviews[index];
                  return PatientReview(
                    imageUrl: reviewItem.user?.profileImage ?? '',
                    name: reviewItem.user?.name ?? 'مريض',
                    rating: reviewItem.rating,
                    review: reviewItem.comment,
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
