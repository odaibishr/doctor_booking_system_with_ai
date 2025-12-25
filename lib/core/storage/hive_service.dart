import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/storage/adapters/safe_doctor_adapter.dart';
import 'package:doctor_booking_system_with_ai/core/storage/adapters/safe_user_adapter.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking_transaction.dart';

class HiveService {
  static const String userBoxName = 'user_box';
  static Box<User>? _userBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // check if adapters are registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SafeUserAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(SafeDoctorAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(HospitalAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LocationAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(SpecialtyAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(BookingAdapter());
    }
    if (!Hive.isAdapterRegistered(12)) {
      Hive.registerAdapter(BookingHistoryScheduleAdapter());
    }
    if (!Hive.isAdapterRegistered(13)) {
      Hive.registerAdapter(BookingTransactionAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(ReviewAdapter());
    }

    _userBox = await Hive.openBox<User>(userBoxName);
    await Hive.openBox<Doctor>(kDoctorBox);
    await Hive.openBox<Specialty>(kSpecialtyBox);
    await Hive.openBox<Hospital>(kHospitalBox);
    await Hive.openBox<Booking>(kBookingHistoryBox);
    await Hive.openBox<Review>(kReviewBox);
  }

  static Future<void> cacheAuthData(User user) async {
    await _userBox?.put('current_user', user);
  }

  static User? getCachedAuthData() {
    return _userBox?.get('current_user');
  }

  static Future<void> clearUser() async {
    await _userBox?.clear();
  }
}
