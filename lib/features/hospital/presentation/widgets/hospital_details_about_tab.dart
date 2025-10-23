import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'hospital_details_service_item.dart';

class HospitalDetailsAboutTab extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;
  final List<Map<String, dynamic>> reviews;

  const HospitalDetailsAboutTab({
    super.key,
    required this.doctors,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'عن المستشفى',
            style: FontStyles.subTitle1.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'مستشفى جامعة العلوم والتكنولوجيا هو أحد أبرز المستشفيات التعليمية والعلاجية في اليمن. '
            'يقدم المستشفى خدمات طبية متكاملة تشمل مختلف التخصصات الطبية مع أحدث الأجهزة والتقنيات الطبية.',
            style: FontStyles.subTitle3,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Text(
            'الخدمات المقدمة',
            style: FontStyles.subTitle1.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          HospitalDetailsServiceItem(service: 'طوارئ 24 ساعة'),
          HospitalDetailsServiceItem(service: 'عيادات خارجية'),
          HospitalDetailsServiceItem(service: 'عمليات جراحية'),
          HospitalDetailsServiceItem(service: 'مختبرات متطورة'),
          HospitalDetailsServiceItem(service: 'أشعة وتشخيص'),
          HospitalDetailsServiceItem(service: 'رعاية مركزة'),
        ],
      ),
    );
  }
}
