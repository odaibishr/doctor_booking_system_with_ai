// lib/service_locator.dart
// Thin orchestrator — all registrations are in lib/injection/
import 'package:get_it/get_it.dart';
import 'package:doctor_booking_system_with_ai/injection/core_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/auth_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/profile_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/home_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/hospital_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/booking_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/favorite_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/search_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/review_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/ai_chat_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/payment_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/notification_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/map_injection.dart';
import 'package:doctor_booking_system_with_ai/injection/doctors_app_injection.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  await CoreInjection.register(serviceLocator);
  AuthInjection.register(serviceLocator);
  ProfileInjection.register(serviceLocator);
  HomeInjection.register(serviceLocator);
  HospitalInjection.register(serviceLocator);
  BookingInjection.register(serviceLocator);
  // FavoriteInjection is a no-op (use cases & cubit already in HomeInjection)
  FavoriteInjection.register(serviceLocator);
  SearchInjection.register(serviceLocator);
  ReviewInjection.register(serviceLocator);
  AiChatInjection.register(serviceLocator);
  PaymentInjection.register(serviceLocator);
  NotificationInjection.register(serviceLocator);
  MapInjection.register(serviceLocator);
  DoctorsAppInjection.register(serviceLocator);
}
