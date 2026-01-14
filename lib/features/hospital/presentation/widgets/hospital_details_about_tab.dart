import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/widgets/hospital_about.dart';
import 'package:flutter/material.dart';
import 'package:doctor_booking_system_with_ai/core/styles/font_styles.dart';
import 'hospital_details_service_item.dart';

class HospitalDetailsAboutTab extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsAboutTab({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final serviceItem = [
      HospitalDetailsServiceItem(service: 'طوارئ 24 ساعة'),
      HospitalDetailsServiceItem(service: 'عيادات خارجية'),
      HospitalDetailsServiceItem(service: 'عمليات جراحية'),
      HospitalDetailsServiceItem(service: 'مختبرات متطورة'),
      HospitalDetailsServiceItem(service: 'أشعة وتشخيص'),
      HospitalDetailsServiceItem(service: 'رعاية مركزة'),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HospitalAbout(hospital: hospital),
          const SizedBox(height: 16),
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

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: serviceItem.length,
            itemBuilder: (context, int index) => serviceItem[index],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
