import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:doctor_booking_system_with_ai/core/storage/hive_service.dart';

abstract class ProfileLocalDataSource {
  Future<void> cachedProfile(Profile profile);
  Future<Profile> getCachedProfile();
  Future<void> clearCachedProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl();

  @override
  Future<void> cachedProfile(Profile profile) async {
    final currentUser = HiveService.getCachedAuthData();
    final profileUser = profile.user;
    final mergedLocation =
        (profileUser.location.id != 0) ? profileUser.location : currentUser?.location;

    final mergedUser = profileUser.copyWith(
      id: profileUser.id != 0 ? profileUser.id : (currentUser?.id ?? 0),
      name: profileUser.name.isNotEmpty ? profileUser.name : (currentUser?.name ?? ''),
      email: profileUser.email.isNotEmpty ? profileUser.email : (currentUser?.email ?? ''),
      token: profileUser.token.isNotEmpty ? profileUser.token : (currentUser?.token ?? ''),
      phone: profile.phone,
      birthDate: profile.birthDate,
      gender: profile.gender,
      locationId: profile.locationId,
      profileImage: profile.profileImage ?? profileUser.profileImage,
      location: mergedLocation ?? profileUser.location,
      address: profileUser.address ?? currentUser?.address,
    );

    await HiveService.cacheAuthData(mergedUser);
  }

  @override
  Future<Profile> getCachedProfile() async {
    final user = HiveService.getCachedAuthData();
    if (user == null) {
      throw Exception('No cached user data');
    }

    return Profile(
      phone: user.phone ?? '',
      birthDate: user.birthDate ?? '',
      gender: user.gender ?? '',
      locationId: user.locationId,
      profileImage: user.profileImage,
      user: user,
    );
  }

  @override
  Future<void> clearCachedProfile() async {
    // Profile data is stored inside cached user now; clearing user is handled by AuthLocalDataSource.
  }
}
