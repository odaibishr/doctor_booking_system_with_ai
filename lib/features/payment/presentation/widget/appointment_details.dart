import 'package:flutter/material.dart';
import 'appointment_details_container.dart';

class AppointmentDetails extends StatelessWidget {
  final String doctorName;
  final String date;
  final String time;
  final double price;

  const AppointmentDetails({
    super.key,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AppointmentDetailsContainer(
            doctorName: doctorName,
            operationNumber: DateTime.now().millisecondsSinceEpoch
                .toString()
                .substring(0, 10),
            date: date,
            period: time,
            price: '$price ريال',
          ),
        ),
      ],
    );
  }
}
