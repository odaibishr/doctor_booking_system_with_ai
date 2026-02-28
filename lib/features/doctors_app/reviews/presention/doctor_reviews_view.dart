import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_app_bar.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_loader.dart';
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
              return Center(
                child: Text(
                  state.message,
                  style: FontStyles.body2.copyWith(color: context.gray600Color),
                ),
              );
            }

            if (state is DoctorReviewsLoaded) {
              if (state.reviews.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        size: 64,
                        color: context.gray400Color,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد مراجعات حتى الآن',
                        style: FontStyles.body1.copyWith(
                          color: context.gray600Color,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  _buildHeader(context, state),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemCount: state.reviews.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final review = state.reviews[index];
                        return _ReviewCard(
                          name: review.user?.name ?? 'مريض',
                          imageUrl: review.user?.profileImage ?? '',
                          rating: review.rating,
                          comment: review.comment,
                          isActive: review.isActive,
                          onToggle: () {
                            context
                                .read<DoctorReviewsCubit>()
                                .toggleReviewActive(review.id);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DoctorReviewsLoaded state) {
    final activeCount = state.reviews.where((r) => r.isActive).length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                Text(
                  state.avgRating.toStringAsFixed(1),
                  style: FontStyles.body2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.totalCount} مراجعة',
                  style: FontStyles.subTitle1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$activeCount نشطة · ${state.totalCount - activeCount} مخفية',
                  style: FontStyles.body3.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int rating;
  final String comment;
  final bool isActive;
  final VoidCallback onToggle;

  const _ReviewCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.comment,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isActive ? 1.0 : 0.55,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.cardBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.3)
                : context.gray300Color,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: FontStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: context.blackColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildStars(context),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Switch.adaptive(
                      value: isActive,
                      onChanged: (_) => onToggle(),
                      activeColor: AppColors.primary,
                    ),
                    Text(
                      isActive ? 'نشطة' : 'مخفية',
                      style: FontStyles.body3.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : context.gray500Color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (comment.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.gray100Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  comment,
                  style: FontStyles.body2.copyWith(color: context.gray600Color),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage = imageUrl.isNotEmpty;
    final url = hasImage
        ? (imageUrl.startsWith('http')
              ? imageUrl
              : '${EndPoints.photoUrl}/$imageUrl')
        : '';

    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      backgroundImage: hasImage ? NetworkImage(url) : null,
      child: hasImage
          ? null
          : const Icon(Icons.person, color: AppColors.primary, size: 26),
    );
  }

  Widget _buildStars(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          i < rating ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 18,
          color: i < rating ? context.yellowColor : context.gray400Color,
        );
      }),
    );
  }
}
