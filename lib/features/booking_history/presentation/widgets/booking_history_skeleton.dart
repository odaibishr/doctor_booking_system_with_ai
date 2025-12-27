import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class BookingHistorySkeleton extends StatelessWidget {
  const BookingHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const BookingItemSkeleton();
      },
    );
  }
}

class BookingItemSkeleton extends StatelessWidget {
  const BookingItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.gray100Color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const CustomShimmer.rectangular(
                  width: 78,
                  height: double.infinity,
                  borderRadius: 10,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomShimmer.rectangular(height: 14, width: 100),
                          CustomShimmer.circular(height: 24, width: 24),
                        ],
                      ),
                      const SizedBox(height: 7),
                      const CustomShimmer.rectangular(height: 16, width: 140),
                      const SizedBox(height: 7),
                      const CustomShimmer.rectangular(height: 14, width: 120),
                      const SizedBox(height: 7),
                      const CustomShimmer.rectangular(height: 12, width: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: CustomShimmer.rectangular(height: 35, borderRadius: 100),
              ),
              SizedBox(width: 16),
              Expanded(
                child: CustomShimmer.rectangular(height: 35, borderRadius: 100),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
