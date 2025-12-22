import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_doctor_skelton.dart';
import 'package:flutter/material.dart';

class SearchViewSkeleton extends StatelessWidget {
  const SearchViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const SearchDoctorSkelton();
      },
    );
  }
}
