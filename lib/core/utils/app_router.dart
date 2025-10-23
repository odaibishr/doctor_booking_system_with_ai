import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/sign_in_view.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signup/presention/sign_up_view.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/details_view.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/hospital/presentation/hospital_details_view.dart';
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
  static const String hospitalDetailsViewRoute = '/hospitalDetailsView';
  static const String signInViewRoute = '/signInView';
  static const String SignupViewRoute='/signupView';

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
        builder: (context, state) => const DetailsView(),
      ),
      GoRoute(
        path: onboardingViewRoute,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: hospitalDetailsViewRoute,
        builder: (context, state) => const HospitalDetailsView(),
      ),
      GoRoute(
        path: signInViewRoute,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: SignupViewRoute,
        builder: (context, state) => const SignUpView(),
      ),
    ],
    initialLocation: splashRoute,
  );
}
