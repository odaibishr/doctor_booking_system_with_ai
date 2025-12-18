import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/models/user_model.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthData(User user);
  Future<UserModel?> getCachedAuthData();
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hiveService;

  AuthLocalDataSourceImpl(this.hiveService);

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
    );
  }

  @override
  Future<void> clearAuthData() async {
    await HiveService.clearUser();
  }
}
