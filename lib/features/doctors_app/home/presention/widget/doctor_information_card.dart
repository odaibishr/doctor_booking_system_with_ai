import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class DoctorInformationCard extends StatelessWidget {
  final String patientName;
  final String patientImage;
  final String time;
  final VoidCallback? onDetails;

  const DoctorInformationCard({
    super.key,
    this.patientName = '',
    this.patientImage = '',
    this.time = '',
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.cardBackgroundColor,
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColors.gray200,
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildImage(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 18),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        patientName,
                        style: FontStyles.body1.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.av_timer, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: FontStyles.body2.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: onDetails,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'تفاصيل',
                        style: FontStyles.body2.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (patientImage.isEmpty) {
      return const Icon(Icons.person, size: 36, color: AppColors.gray500);
    }
    if (patientImage.startsWith('assets/')) {
      return Image.asset(patientImage, fit: BoxFit.cover);
    }
    final url = patientImage.startsWith('http')
        ? patientImage
        : '${EndPoints.photoUrl}/$patientImage';
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.person, size: 36, color: AppColors.gray500),
    );
  }
}
