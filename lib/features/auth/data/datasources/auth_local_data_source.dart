import 'package:doctor_booking_system_with_ai/core/auth/i_token_storage.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/models/user_model.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/user.dart';

abstract class AuthLocalDataSource implements ITokenStorage {
  Future<void> cacheAuthData(User user);
  Future<UserModel?> getCachedAuthData();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl(this.hiveService);

  @override
  Future<String?> getToken() async {
    final cached = await getCachedAuthData();
    return cached?.token;
  }

  @override
  Future<void> cacheAuthData(User user) async {
    final userModel = user is UserModel
        ? user
        : UserModel(
            id: user.id,
            name: user.name,
            email: user.email,
            token: user.token,
            phone: user.phone,
            address: user.address,
            profileImage: user.profileImage,
            birthDate: user.birthDate,
            gender: user.gender,
            location: user.location,
            locationId: user.locationId,
            fcmToken: user.fcmToken,
          );

    await HiveService.cacheAuthData(userModel);
  }

  @override
  Future<UserModel?> getCachedAuthData() async {
    final user = HiveService.getCachedAuthData();
    if (user == null) return null;

    if (user is UserModel) return user;

    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      token: user.token,
      phone: user.phone,
      address: user.address,
      profileImage: user.profileImage,
      birthDate: user.birthDate,
      gender: user.gender,
      location: user.location,
      locationId: user.locationId,
      fcmToken: user.fcmToken,
    );
  }

  @override
  Future<void> clearAuthData() async {
    await HiveService.clearUser();
  }
}
