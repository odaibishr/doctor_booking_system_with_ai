import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/theme/theme_state.dart';
import 'package:doctor_booking_system_with_ai/core/styles/app_theme.dart';
import 'package:doctor_booking_system_with_ai/core/utils/app_router.dart';
import 'package:doctor_booking_system_with_ai/features/auth/presentation/manager/auth_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/manager/profile/profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/toggle_favorite/toggle_favorite_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/search/presentation/manager/search_doctors_bloc/search_doctors_bloc.dart';
import 'package:doctor_booking_system_with_ai/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await init();

  final authCubit = serviceLocator<AuthCubit>();
  await authCubit.checkAuthStatus();

  // Initialize theme cubit
  final themeCubit = serviceLocator<ThemeCubit>();
  await themeCubit.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthCubit>()),
        BlocProvider(
          create: (_) => serviceLocator<ProfileCubit>()..getProfile(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<DoctorCubit>()..fetchDoctors(),
        ),
        BlocProvider(create: (_) => serviceLocator<DoctorDetailsCubit>()),
        BlocProvider(
          create: (_) => serviceLocator<SpecialtyCubit>()..getSpecialties(),
        ),
        BlocProvider(create: (_) => serviceLocator<SearchDoctorsBloc>()),
        BlocProvider(create: (_) => serviceLocator<ToggleFavoriteCubit>()),
        BlocProvider(create: (_) => serviceLocator<FavoriteDoctorCubit>()),
        BlocProvider(
          create: (_) => serviceLocator<HospitalCubit>()..getHospitals(),
        ),
        // Theme Cubit - manages app theme state
        BlocProvider(create: (_) => serviceLocator<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return ToastificationWrapper(
            child: MaterialApp.router(
              title: 'Doctor Booking System',
              routerConfig: AppRouter.router,
              // Theme configuration with Dark Mode support
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('ar')],
              locale: const Locale('ar'),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
