import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/widgets/search_doctor_skelton.dart';

class FavoriteDoctorsSkeleton extends StatelessWidget {
  const FavoriteDoctorsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const SearchDoctorSkelton();
      },
    );
  }
}
