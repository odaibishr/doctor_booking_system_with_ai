import 'package:doctor_booking_system_with_ai/features/app/presentation/app_navigation.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/home_view.dart';
import 'package:doctor_booking_system_with_ai/features/splash/presentation/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String homeViewRoute = '/homeView';
  static const String appNavigationRoute = '/appNavigation';

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
    ],
    initialLocation: splashRoute,
  );
}
