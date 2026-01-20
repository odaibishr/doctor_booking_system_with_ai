import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/entities/user.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class GoogleSignInUseCase {
  final AuthRepo authRepo;

  GoogleSignInUseCase(this.authRepo);

  Future<Either<Failure, User>> call() async {
    return await authRepo.signInWithGoogle();
  }
}
