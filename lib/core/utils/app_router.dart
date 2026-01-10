import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_in_view.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/sign_up_view.dart';
import 'package:doctor_booking_system_with_ai/features/ai_chat/presentation/ai_chat_view.dart';
import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/appointment/presentation/appointment_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/booking_history_view.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/reschedule_appointment_view.dart';
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
import 'package:doctor_booking_system_with_ai/features/map/doctor_map_view.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/pages/my_waitlists_page.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_cubit.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/utils/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  static const String doctorMapViewRoute = '/doctorMapView';
  static const String myWaitlistsViewRoute = '/myWaitlistsView';
  static const String rescheduleAppointmentViewRoute =
      '/rescheduleAppointmentView';

  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      // Splash - no transition needed
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashView(),
      ),
      // Home View - fade transition
      GoRoute(
        path: homeViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: const HomeView(),
          name: homeViewRoute,
        ),
      ),
      // App Navigation - fade transition
      GoRoute(
        path: appNavigationRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: AppNavigation(initialIndex: (state.extra as int?) ?? 0),
          name: appNavigationRoute,
        ),
      ),
      // Search View - slide up transition
      GoRoute(
        path: searchViewRoute,
        pageBuilder: (context, state) {
          final idStr = state.uri.queryParameters["id"];
          final specialtyId = int.tryParse(idStr ?? "");
          return PageTransitionBuilder.slideUp(
            child: SearchView(specialtyQuery: specialtyId),
            name: searchViewRoute,
          );
        },
      ),
      // Booking History - shared axis transition
      GoRoute(
        path: bookingHistoryViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: const BookingHistoryView(),
          name: bookingHistoryViewRoute,
        ),
      ),
      // Profile View - shared axis transition
      GoRoute(
        path: profileViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: const ProfileView(),
          name: profileViewRoute,
        ),
      ),
      // Details View - scale with fade for important content
      GoRoute(
        path: detailsViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.scaleWithFade(
          child: DetailsView(doctorId: state.extra as int),
          name: detailsViewRoute,
        ),
      ),
      // Onboarding - fade transition
      GoRoute(
        path: onboardingViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: const OnBoardingView(),
          name: onboardingViewRoute,
        ),
      ),
      // Hospital Details - scale with fade
      GoRoute(
        path: hospitalDetailsViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.scaleWithFade(
          child: HospitalDetailsView(hospitalId: state.extra as int),
          name: hospitalDetailsViewRoute,
        ),
      ),
      // Auth Views - fade transition for auth flow
      GoRoute(
        path: signInViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: const SignInView(),
          name: signInViewRoute,
        ),
      ),
      GoRoute(
        path: signupViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: const SignUpView(),
          name: signupViewRoute,
        ),
      ),
      GoRoute(
        path: createprofileViewRout,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: const CreateProfileView(),
          name: createprofileViewRout,
        ),
      ),
      // Forget Password Flow - fade through for sequential steps
      GoRoute(
        path: emailinputViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fadeThrough(
          child: const EmailInputView(),
          name: emailinputViewRoute,
        ),
      ),
      GoRoute(
        path: verifyCodeViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fadeThrough(
          child: const VerifyCodeView(),
          name: verifyCodeViewRoute,
        ),
      ),
      GoRoute(
        path: createNewPasswordViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fadeThrough(
          child: const CreateNewPasswordView(),
          name: createNewPasswordViewRoute,
        ),
      ),
      // Appointment - slide up for modal-like behavior
      GoRoute(
        path: appointmentViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.slideUp(
          child: AppointmentView(doctor: state.extra as Doctor),
          name: appointmentViewRoute,
        ),
      ),
      // AI Chat - scale with fade
      GoRoute(
        path: aichatViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.scaleWithFade(
          child: AiChatView(),
          name: aichatViewRoute,
        ),
      ),
      // Category View - shared axis
      GoRoute(
        path: categoryViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: const CategoryView(),
          name: categoryViewRoute,
        ),
      ),
      // Payment - slide up for important action
      GoRoute(
        path: paymentViewRoute,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return PageTransitionBuilder.slideUp(
            child: PaymentView(
              doctor: extra['doctor'] as Doctor,
              date: extra['date'] as DateTime,
              time: extra['time'] as String,
              doctorScheduleId: extra['scheduleId'] as int?,
            ),
            name: paymentViewRoute,
          );
        },
      ),
      // Favorite Doctor - shared axis
      GoRoute(
        path: favoritedoctorViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: const FavoratieDoctorView(),
          name: favoritedoctorViewRoute,
        ),
      ),
      // Add Card - slide up for form
      GoRoute(
        path: addcardViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.slideUp(
          child: const AddCardView(),
          name: addcardViewRoute,
        ),
      ),
      // Notification - fade transition
      GoRoute(
        path: notificationViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.fade(
          child: NotificationView(),
          name: notificationViewRoute,
        ),
      ),
      // Top Doctors - shared axis
      GoRoute(
        path: topDoctorsViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: const TopDoctorsView(),
          name: topDoctorsViewRoute,
        ),
      ),
      // Doctor Map - scale with fade
      GoRoute(
        path: doctorMapViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.scaleWithFade(
          child: DoctorMapPage(initialDoctor: state.extra as Doctor?),
          name: doctorMapViewRoute,
        ),
      ),
      // My Waitlists - shared axis
      GoRoute(
        path: myWaitlistsViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.sharedAxis(
          child: BlocProvider(
            create: (_) => serviceLocator<WaitlistCubit>()..loadMyWaitlists(),
            child: const MyWaitlistsPage(),
          ),
          name: myWaitlistsViewRoute,
        ),
      ),
      // Reschedule Appointment - slide up
      GoRoute(
        path: rescheduleAppointmentViewRoute,
        pageBuilder: (context, state) => PageTransitionBuilder.slideUp(
          child: BlocProvider(
            create: (_) => serviceLocator<BookingHistoryCubit>(),
            child: RescheduleAppointmentView(booking: state.extra as Booking),
          ),
          name: rescheduleAppointmentViewRoute,
        ),
      ),
    ],
    initialLocation: splashRoute,
  );
}
