import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> signIn(
    String email,
    String password,
    String? fcm_token,
  );
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  );

  Future<Either<Failure, User>> logout();

  Future<Either<Failure, User?>> getCurrentUser();

  Future<Either<Failure, User>> signInWithGoogle({
    required String name,
    required String email,
    required String googleId,
    required String idToken,
    String? photoUrl,
    String? fcmToken,
  });
}
