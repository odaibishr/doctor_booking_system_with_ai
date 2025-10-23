import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/patient_review.dart';

class HospitalDetailsReviewsTab extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const HospitalDetailsReviewsTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return PatientReview(
          name: review['name'],
          rating: review['rating'],
          review: review['review'],
        );
      },
    );
  }
}
