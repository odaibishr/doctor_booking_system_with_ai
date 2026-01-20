import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/repos/logout_repo.dart';

import 'package:doctor_booking_system_with_ai/core/services/google_sign_in_service.dart';

class LogoutRepoImpl implements LogoutRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  final GoogleSignInService googleSignInService;

  LogoutRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.profileLocalDataSource,
    this.googleSignInService,
  );
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final user = await localDataSource.getCachedAuthData();
      final token = user?.token ?? '';

      if (token.isNotEmpty) {
        try {
          await remoteDataSource.logout(token);
        } catch (e) {
          // Log only, don't stop the local logout process
          // This ensures the user can always sign out of the app even if the server is down or errors out
          print("Server logout failed: $e, proceeding with local logout.");
        }
      }

      // Sign out from Google to allow account switching
      await googleSignInService.signOut();

      await localDataSource.clearAuthData();
      await profileLocalDataSource.clearCachedProfile();
      return const Right(null);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
