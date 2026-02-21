import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/next_appintment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/previous_appointment_page.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/home/presention/widget/top_button.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePageViewBody extends StatefulWidget {
  const HomePageViewBody({super.key});

  @override
  State<HomePageViewBody> createState() => _HomePageViewBodyState();
}

class _HomePageViewBodyState extends State<HomePageViewBody> {
  int SelectedIndex = 0;
  List<Widget>_pages=[
    NextAppintmentPage(),
    PreviousAppointmentPage()
  ];
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 25, bottom: 120),
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF364989),

          child: CustomHomeAppBar(
            name: 'مرحبًا د/محمد ',
            userImage: 'assets/images/my-photo.jpg',
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TopButton(
                        Index: 0,
                        OnTap: () {
                          setState(() {
                            SelectedIndex = 0;
                          });
                        },
                        SelectedIndex: SelectedIndex,
                        Title: 'الحجوزات القادمة',
                      ),
                      TopButton(
                        Index: 1,
                        OnTap: () {
                          setState(() {
                            SelectedIndex = 1;
                          });
                        },
                        SelectedIndex: SelectedIndex,
                        Title: 'الحجوزات السابقة',
                      ),
                    ],
                  ),
                  Expanded(
                    child: _pages[SelectedIndex])
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
