import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_booking_system_with_ai/core/database/api/end_points.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_colors.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'package:flutter/material.dart';

class PatientInfoSection extends StatelessWidget {
  const PatientInfoSection({
    super.key,
    required this.patientName,
    required this.patientImage,
    required this.bookingNumber,
    this.isNew = false,
    this.isCancelled = false,
    this.isCompleted = false,
    this.isConfirmed = false,
  });

  final String patientName;
  final String patientImage;
  final String bookingNumber;
  final bool isNew;
  final bool isCancelled;
  final bool isCompleted;
  final bool isConfirmed;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: context.gray200Color,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildImage(),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      patientName,
                      style: FontStyles.subTitle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isCancelled) ...[
                    const SizedBox(width: 8),
                    _buildCancelledBadge(context),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'رقم الحجز : $bookingNumber',
                style: FontStyles.body2.copyWith(color: context.gray500Color),
              ),
            ],
          ),
        ),
        if (isNew) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.getGray200(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'جديد',
              style: FontStyles.body3.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        if (isCompleted) ...[
          const SizedBox(width: 8),
          _buildCompletedBadge(context),
        ],
        if (isConfirmed) ...[
          const SizedBox(width: 8),
          _buildConfirmedBadge(context),
        ],
      ],
    );
  }

  Widget _buildCancelledBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.getError(context).withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel, color: AppColors.getError(context), size: 13),
          const SizedBox(width: 3),
          Text(
            'ملغي',
            style: TextStyle(
              color: AppColors.getError(context),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.getSuccess(context).withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.getSuccess(context),
            size: 13,
          ),
          const SizedBox(width: 3),
          Text(
            'مكتمل',
            style: TextStyle(
              color: AppColors.getSuccess(context),
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: context.gray200Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, color: context.gray500Color, size: 13),
          const SizedBox(width: 3),
          Text(
            'مؤكد',
            style: TextStyle(
              color: context.gray500Color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (patientImage.isEmpty) {
      return const Icon(Icons.person, size: 36, color: AppColors.gray400);
    }
    if (patientImage.startsWith('assets/')) {
      return Image.asset(patientImage, fit: BoxFit.cover);
    }
    final url = patientImage.startsWith('http')
        ? patientImage
        : '${EndPoints.photoUrl}/$patientImage';
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) =>
          const Icon(Icons.person, size: 36, color: AppColors.gray400),
    );
  }
}
