import 'package:doctor_booking_system_with_ai/features/Auth/signin/presention/sign_in_view.dart';
import 'package:doctor_booking_system_with_ai/features/Auth/signup/presention/sign_up_view.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presention/ai_chat_view.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/appointment_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/categorys/presention/category_view.dart';
import 'package:doctor_booking_system_with_ai/features/create_profile/presention/create_profile_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/create_new_password.dart/presention/create_new_passwod_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/email_input/presention/email_input_view.dart';
import 'package:doctor_booking_system_with_ai/features/forget_password/verfiy_code/presention/verfiy_code_view.dart';
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
  static const String signupViewRoute = '/signupView';
  static const String createprofileViewRout = '/createprofileView';
  static const String emailinputViewRoute = '/emailinputView';
  static const String verfiycodeViewRout = '/verfiycodeView';
  static const String createnewpasswordViewRoute = '/createnewpasswordView';
  static const String appointmentViewRoute = '/appointmentView';
  static const String aichatViewRoute = '/aichatView';
  static const String categoryViewRoute='/categoryView';

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
        path: verfiycodeViewRout,
        builder: (context, state) => const VerfiyCodeView(),
      ),
      GoRoute(
        path: createnewpasswordViewRoute,
        builder: (context, state) => const CreateNewPasswodView(),
      ),
      GoRoute(
        path: appointmentViewRoute,
        builder: (context, state) => const AppointmentView(),
      ),
      GoRoute(
        path: aichatViewRoute,
        builder: (context, state) => const AiChatView(),
      ),
      GoRoute(
        path: categoryViewRoute,
        builder: (context, state) =>const CategoryView(),
      ),
    ],
    initialLocation: splashRoute,
  );
}
