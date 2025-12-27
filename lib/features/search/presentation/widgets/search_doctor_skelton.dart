import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class SearchDoctorSkelton extends StatelessWidget {
  const SearchDoctorSkelton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 165,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.gray100Color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                CustomShimmer.rectangular(
                  height: double.infinity,
                  width: 70,
                  borderRadius: 10,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CustomShimmer.rectangular(height: 16, width: 150),
                      const CustomShimmer.rectangular(height: 14, width: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CustomShimmer.rectangular(height: 14, width: 40),
                          CustomShimmer.rectangular(height: 14, width: 60),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CustomShimmer.rectangular(
            height: 30,
            width: double.infinity,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
