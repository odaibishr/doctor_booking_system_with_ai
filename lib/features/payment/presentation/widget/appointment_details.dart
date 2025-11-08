import 'package:flutter/material.dart';
import 'appointment_details_container.dart';

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AppointmentDetailsContainer(
          doctorName: 'صادق محمد بشر',
          operationNumber: '1017331120',
          date: '30 يوليو 2025',
          period: '10ص - 1م',
          price: '5000 ريال',
        ),
      ],
    );
  }
}
