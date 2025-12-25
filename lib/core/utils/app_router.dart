import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_in_view.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_up_view.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/ai_chat_view.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/appointment_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/categories/presentation/category_view.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presentation/create_profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/favorite_doctor_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/create_new_password/presentation/create_new_password_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/email_input/presentation/email_input_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/verify_code/presentation/verify_code_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/details_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/hospital_details_view.dart';
import 'package:doctor_booking_system_with_ai/features/notification/presentation/notification_view.dart';
import 'package:doctor_booking_system_with_ai/features/onboarding/presentation/onboarding_view.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/add_card_view.dart';
import 'package:doctor_booking_system_with_ai/features/payment/presentation/payment_view.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/search_view.dart';
import 'package:doctor_booking_system_with_ai/features/splash/presentation/splash_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/top_doctors_view.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String splashRoute = '/';
  static const String homeViewRoute = '/homeView';
  static const String appNavigationRoute = '/appNavigation';
  static const String searchViewRoute = '/searchView';
  static const String bookingHistoryViewRoute = '/bookingHistoryView';
  static const String profileViewRoute = '/profileView';
  static const String detailsViewRoute = '/detailsView';
  static const String onboardingViewRoute = '/onboardingView';
  static const String hospitalDetailsViewRoute = '/hospitalDetailsView';
  static const String signInViewRoute = '/signInView';
  static const String signupViewRoute = '/signupView';
  static const String createprofileViewRout = '/createprofileView';
  static const String emailinputViewRoute = '/emailinputView';
  static const String verifyCodeViewRoute = '/verifycodeView';
  static const String createNewPasswordViewRoute = '/createnewpasswordView';
  static const String appointmentViewRoute = '/appointmentView';
  static const String aichatViewRoute = '/aichatView';
  static const String categoryViewRoute = '/categoryView';
  static const String paymentViewRoute = '/paymentView';
  static const String favoritedoctorViewRoute = '/favoritedoctorView';
  static const String addcardViewRoute = '/addcardView';
  static const String notificationViewRoute = '/notificationView';
  static const String topDoctorsViewRoute = '/topDoctorsView';

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: homeViewRoute,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: appNavigationRoute,
        builder: (context, state) =>
            AppNavigation(initialIndex: (state.extra as int?) ?? 0),
      ),
      GoRoute(
        path: searchViewRoute,
        builder: (context, state) {
          final idStr = state.uri.queryParameters["id"];
          final specialtyId = int.tryParse(idStr ?? "");

          return SearchView(specialtyQuery: specialtyId);
        },
      ),
      GoRoute(
        path: bookingHistoryViewRoute,
        builder: (context, state) => const BookingHistoryView(),
      ),
      GoRoute(
        path: profileViewRoute,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: detailsViewRoute,
        builder: (context, state) => DetailsView(doctorId: state.extra as int),
      ),
      GoRoute(
        path: onboardingViewRoute,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: hospitalDetailsViewRoute,
        builder: (context, state) =>
            HospitalDetailsView(hospitalId: state.extra as int),
      ),
      GoRoute(
        path: signInViewRoute,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: signupViewRoute,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: createprofileViewRout,
        builder: (context, state) => const CreateProfileView(),
      ),
      GoRoute(
        path: emailinputViewRoute,
        builder: (context, state) => const EmailInputView(),
      ),
      GoRoute(
        path: verifyCodeViewRoute,
        builder: (context, state) => const VerifyCodeView(),
      ),
      GoRoute(
        path: createNewPasswordViewRoute,
        builder: (context, state) => const CreateNewPasswordView(),
      ),
      GoRoute(
        path: appointmentViewRoute,
        builder: (context, state) =>
            AppointmentView(doctor: state.extra as Doctor),
      ),
      GoRoute(path: aichatViewRoute, builder: (context, state) => AiChatView()),
      GoRoute(
        path: categoryViewRoute,
        builder: (context, state) => const CategoryView(),
      ),
      GoRoute(
        path: paymentViewRoute,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PaymentView(
            doctor: extra['doctor'] as Doctor,
            date: extra['date'] as DateTime,
            time: extra['time'] as String,
            doctorScheduleId: extra['scheduleId'] as int?,
          );
        },
      ),
      GoRoute(
        path: favoritedoctorViewRoute,
        builder: (context, state) => const FavoratieDoctorView(),
      ),
      GoRoute(
        path: addcardViewRoute,
        builder: (context, state) => const AddCardView(),
      ),
      GoRoute(
        path: notificationViewRoute,
        builder: (context, state) => NotificationView(),
      ),
      GoRoute(
        path: topDoctorsViewRoute,
        builder: (context, state) => const TopDoctorsView(),
      ),
    ],
    initialLocation: splashRoute,
  );
}
