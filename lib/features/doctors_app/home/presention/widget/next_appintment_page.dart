import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/dappointment_card.dart';
import 'package:flutter/material.dart';

class NextAppintmentPage extends StatefulWidget {
  const NextAppintmentPage({super.key});

  @override
  State<NextAppintmentPage> createState() => _NextAppintmentPageState();
}

class _NextAppintmentPageState extends State<NextAppintmentPage> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 20,left: 12,right: 12),
      child: Container(child: ListView(
        
        children: [
          DAppointmentCard(),
          DAppointmentCard(),
          DAppointmentCard(),
         
      
        ],
      ),),
    );
  }
}

