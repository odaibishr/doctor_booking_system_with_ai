import 'package:doctor_booking_system_with_ai/features/home/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/location.dart';
import 'package:doctor_booking_system_with_ai/features/home/domain/entities/specialty.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

class HiveService {
  static const String userBoxName = 'user_box';
  static Box<User>? _userBox;
  static const String doctorBoxName = 'doctors_box';
  static Box<Doctor>? _doctorBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    // check if adapters are registered
    checkIsAdapterRegistered(adapterNumber: 0, adapter: UserAdapter());
    checkIsAdapterRegistered(adapterNumber: 2, adapter: DoctorAdapter());
    checkIsAdapterRegistered(adapterNumber: 3, adapter: HospitalAdapter());
    checkIsAdapterRegistered(adapterNumber: 4, adapter: LocationAdapter());
    checkIsAdapterRegistered(adapterNumber: 5, adapter: SpecialtyAdapter());

    _userBox = await Hive.openBox<User>(userBoxName);
    _doctorBox = await Hive.openBox<Doctor>(doctorBoxName);
  }

  static void checkIsAdapterRegistered({
    required int adapterNumber,
    required TypeAdapter adapter,
  }) {
    if (!Hive.isAdapterRegistered(adapterNumber)) {
      Hive.registerAdapter(adapter);
    }
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
