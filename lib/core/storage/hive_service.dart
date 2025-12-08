import 'package:doctor_booking_system_with_ai/core/utils/constant.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

class HiveService {
  static const String userBoxName = 'user_box';
  static Box<User>? _userBox;
  static Box<Doctor>? _doctorBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // check if adapters are registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(DoctorAdapter());
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

    _userBox = await Hive.openBox<User>(userBoxName);
    _doctorBox = await Hive.openBox<Doctor>(kDoctorBox);
    await Hive.openBox<Specialty>(kSpecialtyBox);
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
