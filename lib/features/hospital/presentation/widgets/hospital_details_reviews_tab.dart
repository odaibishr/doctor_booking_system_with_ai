import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/review_dialog.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_details_review_slider.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HospitalDetailsReviewsTab extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const HospitalDetailsReviewsTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (context) => ReviewDialog(onSubmit: (reason) {}),
            );
          },
          child: Row(
            children: [
              Text(
                'إضافة مراجعة',
                style: FontStyles.body1.copyWith(color: AppColors.primary),
              ),
              const SizedBox(width: 5),
              SvgPicture.asset('assets/icons/edit-2.svg'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        HospitalDetailsReviewSlider(reviews: reviews),
      ],  
    );
  }
}
