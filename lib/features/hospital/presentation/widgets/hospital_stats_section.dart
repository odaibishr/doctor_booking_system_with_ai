import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/states_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class HospitalStatsSection extends StatelessWidget {
  const HospitalStatsSection({super.key, required this.hospital});

  final Hospital hospital;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _shareHospital() {
    Share.share(
      'مستشفى ${hospital.name}\nالعنوان: ${hospital.address}\nللتواصل: ${hospital.phone}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatesItem(
          icon: 'assets/icons/send-2.svg',
          text: 'مشاركة',
          onTap: _shareHospital,
        ),
        StatesItem(
          icon: 'assets/icons/chrome.svg',
          text: 'صفحتنا',
          onTap: () {
            if (hospital.website.isNotEmpty) {
              _launchUrl(hospital.website);
            }
          },
        ),
        StatesItem(
          icon: 'assets/icons/call.svg',
          text: 'اتصل بنا',
          onTap: () {
            if (hospital.phone.isNotEmpty) {
              _launchPhone(hospital.phone);
            }
          },
        ),
        StatesItem(
          icon: 'assets/icons/map.svg',
          text: 'الاتجاهات',
          onTap: () {
            if (hospital.doctors != null && hospital.doctors!.isNotEmpty) {
              context.push(
                AppRouter.doctorMapViewRoute,
                extra: hospital.doctors!.first,
              );
            } else {
              context.push(AppRouter.doctorMapViewRoute);
            }
          },
        ),
      ],
    );
  }
}
