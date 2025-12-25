import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/widgets/states_item.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DoctorStatsSection extends StatefulWidget {
  const DoctorStatsSection({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<DoctorStatsSection> createState() => _DoctorStatsSectionState();
}

class _DoctorStatsSectionState extends State<DoctorStatsSection> {
  String distance = '...';

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  void _openMap() {
    if (!mounted) return;
    try {
      context.push(AppRouter.doctorMapViewRoute, extra: widget.doctor);
    } catch (e) {
      debugPrint("Map Navigation Error: $e");
    }
  }

  Future<void> _calculateDistance() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) setState(() => distance = 'GPS Off');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => distance = 'No Perm');
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      ).timeout(const Duration(seconds: 4));

      if (mounted) {
        double dist = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          widget.doctor.location.lat,
          widget.doctor.location.lng,
        );
        setState(() {
          if (dist < 1000) {
            distance = '${dist.toStringAsFixed(0)}m';
          } else {
            distance = '${(dist / 1000).toStringAsFixed(1)}km';
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => distance = '...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatesItem(
          icon: 'assets/icons/people.svg',
          text: 'مريض',
          number: '${widget.doctor.experience * 150}+', // Example logic
        ),
        StatesItem(
          icon: 'assets/icons/calendar1.svg',
          text: 'خبرة',
          number: '${widget.doctor.experience}Y+',
        ),
        StatesItem(
          icon: 'assets/icons/star.svg',
          text: 'التقييم',
          number: '4.9+',
        ),
        StatesItem(
          icon: 'assets/icons/map.svg',
          text: 'الموقع',
          number: distance,
          onTap: _openMap,
        ),
      ],
    );
  }
}
