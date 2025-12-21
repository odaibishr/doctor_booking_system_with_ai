import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_booking_system_with_ai/core/manager/review/review_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/patient_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientReviewSlider extends StatefulWidget {
  const PatientReviewSlider({super.key, required this.doctorId});
  final int doctorId;

  @override
  State<PatientReviewSlider> createState() => _PatientReviewSliderState();
}

class _PatientReviewSliderState extends State<PatientReviewSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getDoctorReviews(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewInitial) {
          return const CustomLoader(loaderSize: kLoaderSize);
        }
        if (state is ReviewLoading) {
          return const CustomLoader(loaderSize: kLoaderSize);
        }
        if (state is ReviewFailure) {
          return Center(
            child: Text(
              state.message,
              style: FontStyles.body3.copyWith(color: AppColors.gray600),
            ),
          );
        }
        if (state is! ReviewLoaded) {
          return const SizedBox.shrink();
        }
        if (state.reviews.isEmpty) {
          return Center(
            child: Text(
              'لا توجد مراجعات حتى الآن',
              style: FontStyles.body3.copyWith(color: AppColors.gray600),
            ),
          );
        }
        if (state.reviews.isEmpty) {
          log(state.reviews.length.toString());
          return Center(
            child: Text(
              'لا توجد مراجعات حتى الآن',
              style: FontStyles.body3.copyWith(color: AppColors.gray600),
            ),
          );
        }
        return CarouselSlider.builder(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 90,
            viewportFraction: 0.85,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final review = state.reviews[index];
            return PatientReview(
              imageUrl: review.user!.profileImage!,
              name: review.user!.name,
              rating: review.rating,
              review: review.comment,
            );
          },
          itemCount: state.reviews.length,
        );
      },
    );
  }
}
