import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, User>> logout() async {
    try {
      await authLocalDataSource.clearAuthData();
      await authRemoteDataSource.logout('');
      return Right(User(id: 0, name: '', email: '', token: ''));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      log("Attempting to sign in with email: $email");
      final result = await authRemoteDataSource.signIn(email, password);
      await authLocalDataSource.cacheAuthData(result);
      log("Sign in successful for user: ${result.email}");
      return Right(result);
    } catch (e) {
      log("Sign in failed with error: $e");
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await authRemoteDataSource.signUp(name, email, password);
      await authLocalDataSource.cacheAuthData(result);
      return Right(result);
    } catch (e) {
      log("Sign up failed with error: $e");
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final authData = await authLocalDataSource.getCachedAuthData();
      if (authData != null) {
        final user = authData;
        return Right(user);
      }
      return const Right(null);
    } catch (e) {
      log("Error getting current user: $e");
      return Left(Failure(e.toString()));
    }
  }
}
