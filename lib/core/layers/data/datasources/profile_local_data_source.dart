import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/profile.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ProfileLocalDataSource {
  Future<void> cachedProfile(Profile profile);
  Future<Profile> getCachedProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box<Profile> profileBox;
  ProfileLocalDataSourceImpl(this.profileBox);

  @override
  Future<void> cachedProfile(Profile profile) async {
    await profileBox.put(profile.phone, profile);
  }

  @override
  Future<Profile> getCachedProfile() async {
    return profileBox.get(profileBox.keys.first)!;
  }
}
