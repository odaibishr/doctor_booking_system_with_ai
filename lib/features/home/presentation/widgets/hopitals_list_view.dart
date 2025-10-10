import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/hospital_card.dart';
import 'package:flutter/material.dart';

class HopitalsListView extends StatefulWidget {
  const HopitalsListView({super.key});

  @override
  State<HopitalsListView> createState() => _HopitalsListViewState();
}

class _HopitalsListViewState extends State<HopitalsListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: const HospitalCard(),
          );
        },
      ),
    );
  }
}
