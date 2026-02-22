import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/doctor_information_card.dart';
import 'package:flutter/material.dart';

class PreviousAppointmentPage extends StatefulWidget {
  const PreviousAppointmentPage({super.key});

  @override
  State<PreviousAppointmentPage> createState() => _PreviousAppointmentPageState();
}

class _PreviousAppointmentPageState extends State<PreviousAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
      child: ListView(children: [
        DoctorInformationCard(),
        DoctorInformationCard(),
        DoctorInformationCard(),
      ],),
    );
  }
}

