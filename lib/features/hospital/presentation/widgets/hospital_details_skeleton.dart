import 'package:doctor_booking_system_with_ai/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class HospitalDetailsSkeleton extends StatelessWidget {
  const HospitalDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomShimmer.rectangular(
            height: 189,
            width: double.infinity,
            borderRadius: 12,
          ),
          const SizedBox(height: 16),
          const CustomShimmer.rectangular(height: 24, width: 200),
          const SizedBox(height: 8),
          const CustomShimmer.rectangular(height: 16, width: 150),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              4,
              (index) => Column(
                children: const [
                  CustomShimmer.circular(height: 48, width: 48),
                  SizedBox(height: 8),
                  CustomShimmer.rectangular(height: 12, width: 40),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              CustomShimmer.rectangular(
                height: 35,
                width: 80,
                borderRadius: 20,
              ),
              CustomShimmer.rectangular(
                height: 35,
                width: 80,
                borderRadius: 20,
              ),
              CustomShimmer.rectangular(
                height: 35,
                width: 80,
                borderRadius: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const CustomShimmer.rectangular(height: 20, width: 100),
          const SizedBox(height: 12),
          const CustomShimmer.rectangular(height: 14, width: double.infinity),
          const SizedBox(height: 8),
          const CustomShimmer.rectangular(height: 14, width: double.infinity),
          const SizedBox(height: 8),
          const CustomShimmer.rectangular(height: 14, width: 200),
          const SizedBox(height: 24),
          const CustomShimmer.rectangular(height: 20, width: 120),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) => const CustomShimmer.rectangular(
                height: 100,
                width: 100,
                borderRadius: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
