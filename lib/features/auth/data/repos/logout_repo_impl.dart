import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/core/layers/data/datasources/profile_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/repos/logout_repo.dart';

class LogoutRepoImpl implements LogoutRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  LogoutRepoImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.profileLocalDataSource,
  );
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final user = await localDataSource.getCachedAuthData();
      final token = user?.token ?? '';

      if (token.isNotEmpty) {
        await remoteDataSource.logout(token);
      }

      await localDataSource.clearAuthData();
      await profileLocalDataSource.clearCachedProfile();
      return const Right(null);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
