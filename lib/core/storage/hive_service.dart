import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

class HiveService {
  static const String userBoxName = 'user_box';
  static Box<User>? _userBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    _userBox = await Hive.openBox<User>(userBoxName);
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
