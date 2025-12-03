import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_in_view.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_up_view.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/ai_chat_view.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/appointment_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/categorys/presention/category_view.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/create_profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/favoratie_doctor/presention/favorite_doctor_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/create_new_password.dart/presention/create_new_passwod_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/email_input/presention/email_input_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/verfiy_code/presention/verfiy_code_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/details_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/onboarding/presention/onboarding_view.dart';
import 'package:doctor_booking_system_with_ai/features/profile/presentation/profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/search_view.dart';
import 'package:doctor_booking_system_with_ai/features/splash/presentation/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String homeViewRoute = '/homeView';
  static const String appNavigationRoute = '/appNavigation';
  static const String searchViewRoute = '/searchView';
  static const String bookingHistoryViewRoute = '/bookingHistoryView';
  static const String profileViewRoute = '/profileView';
  static const String detailsViewRoute = '/detailsView';
  static const String onboardingViewRoute = '/onboardingView';
  
  static GoRouter router = GoRouter(
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
        builder: (context, state) => const AppNavigation(),
      ),
      GoRoute(
        path: searchViewRoute,
        builder: (context, state) => const SearchView(),
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
        builder: (context, state) => DetailsView(doctor: state.extra as Doctor),
      ),
      GoRoute(
        path: onboardingViewRoute,
        builder: (context, state) => const OnBoardingView(),
      ),
    ],
    initialLocation: splashRoute,
  );
}
