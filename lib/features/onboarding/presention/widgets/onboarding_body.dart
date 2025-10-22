import 'package:doctor_booking_system_with_ai/features/onboarding/models/onboarding_data_model.dart';
import 'package:doctor_booking_system_with_ai/features/onboarding/presention/widgets/onboardingpages.dart';
import 'package:flutter/material.dart';


class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int _currentIndex = 0;
  late PageController pageController;
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }
//i create from class and this object to use it!
  List<OnboardingDataModel> onboardingData = [
     OnboardingDataModel(
      image: 'assets/images/onboarding1.png',
      title: "احجز موعدا مع طبيب عبر الأنترنت ",
      description:"سجل واحجز استشارة طبية اونلاين مع أفضل الأطباء المتخصصين في أي وقت ومن أي مكان",
    ),
    OnboardingDataModel(
      image: 'assets/images/onboarding2.png',
      title: "طبيبك الذكي",
      description: "يحلل الذكاء الاصطناعي فحوصاتك، ويختار الطبيب المختص ويحجز موعدك آلياً - راحة وسرعة ودقة!",
    ),
     OnboardingDataModel(
      image: 'assets/images/onboarding3.png',
      title: "تذكيرك بموعدك",
      description:"يتابع تطبيقنا مواعيدك ويذكرك بها مسبقاً عبر التنبيهات، مع تفاصيل العيادة ومتى دخولك عند الطبيب.",
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      itemCount: onboardingData.length,
      controller: pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemBuilder: (contex, index) {
        return Onboardingpages(
          index: _currentIndex,
          image: onboardingData[index].image!,
          title: onboardingData[index].title,
          description: onboardingData[index].description,
          pagecontroller: pageController,
        );
      },
    );
  }
}
