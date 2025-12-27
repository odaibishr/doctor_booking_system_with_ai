import 'package:flutter/material.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_shimmer.dart';

class DoctorCardSkeleton extends StatelessWidget {
  const DoctorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 205,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.cardBackgroundColor, // Or gray100 base if mimics card
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.gray200Color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          const CustomShimmer.rectangular(
            height: 90,
            width: double.infinity,
            borderRadius: 6,
          ),
          const SizedBox(height: 12),

          // Name and Favorite Icon
          const Row(
            children: [
              CustomShimmer.rectangular(
                height: 16,
                width: 100,
                borderRadius: 4,
              ),
              Spacer(),
              CustomShimmer.circular(height: 24, width: 24),
            ],
          ),
          const SizedBox(height: 8),

          // Specialty
          const CustomShimmer.rectangular(
            height: 14,
            width: 80,
            borderRadius: 4,
          ),
          const SizedBox(height: 12),

          // Rating and Price
          const Row(
            children: [
              CustomShimmer.rectangular(height: 14, width: 40, borderRadius: 4),
              Spacer(),
              CustomShimmer.rectangular(height: 14, width: 60, borderRadius: 4),
            ],
          ),
        ],
      ),
    );
  }
}
