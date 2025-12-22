import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_shimmer.dart';
import 'doctor_card_skeleton.dart';

class HomeViewSkeleton extends StatelessWidget {
  const HomeViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // Banner Skeleton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: const CustomShimmer.rectangular(
            height: 160,
            width: double.infinity,
            borderRadius: 12,
          ),
        ),
        const SizedBox(height: 24),

        // Categories Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomShimmer.rectangular(height: 20, width: 100),
              CustomShimmer.rectangular(height: 20, width: 60),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Categories List Skeleton
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => Column(
              children: const [
                CustomShimmer.circular(width: 50, height: 50),
                SizedBox(height: 8),
                CustomShimmer.rectangular(width: 40, height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Top Doctors Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomShimmer.rectangular(height: 20, width: 120),
              CustomShimmer.rectangular(height: 20, width: 60),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Top Doctors List Skeleton
        SizedBox(
          height: 205,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => const DoctorCardSkeleton(),
          ),
        ),

        const SizedBox(height: 24),
        // Hospitals Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomShimmer.rectangular(height: 20, width: 100),
              CustomShimmer.rectangular(height: 20, width: 60),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Hospitals List Skeleton
        SizedBox(
          height: 205,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => const DoctorCardSkeleton(),
          ),
        ),
      ],
    );
  }
}
