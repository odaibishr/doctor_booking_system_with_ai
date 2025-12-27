import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class DoctorDetailsSkeleton extends StatelessWidget {
  const DoctorDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling while loading
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmer.rectangular(
            height: 190,
            width: double.infinity,
            borderRadius: 12,
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomShimmer.rectangular(height: 24, width: 150),
              CustomShimmer.rectangular(height: 18, width: 100),
            ],
          ),
          const SizedBox(height: 10),

          const CustomShimmer.rectangular(height: 16, width: 120),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.gray200Color),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatItemSkeleton(),
                _StatItemSkeleton(),
                _StatItemSkeleton(),
              ],
            ),
          ),
          const SizedBox(height: 22),

          const CustomShimmer.rectangular(height: 20, width: 100),
          const SizedBox(height: 10),
          const CustomShimmer.rectangular(height: 14, width: double.infinity),
          const SizedBox(height: 6),
          const CustomShimmer.rectangular(height: 14, width: double.infinity),
          const SizedBox(height: 6),
          const CustomShimmer.rectangular(height: 14, width: 250),

          const SizedBox(height: 22),

          const CustomShimmer.rectangular(height: 20, width: 100),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              4,
              (index) => const CustomShimmer.rectangular(
                height: 32,
                width: 80,
                borderRadius: 20,
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomShimmer.rectangular(height: 20, width: 120),
              CustomShimmer.rectangular(height: 20, width: 60),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.gray100Color,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomShimmer.circular(height: 40, width: 40),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CustomShimmer.rectangular(height: 14, width: 100),
                        SizedBox(height: 4),
                        CustomShimmer.rectangular(height: 12, width: 60),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const CustomShimmer.rectangular(
                  height: 14,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItemSkeleton extends StatelessWidget {
  const _StatItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomShimmer.circular(height: 40, width: 40),
        SizedBox(height: 8),
        CustomShimmer.rectangular(height: 12, width: 60),
        SizedBox(height: 4),
        CustomShimmer.rectangular(height: 10, width: 40),
      ],
    );
  }
}
