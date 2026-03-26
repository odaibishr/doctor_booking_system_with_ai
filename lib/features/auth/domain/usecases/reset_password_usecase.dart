import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class ResetPasswordUseCase extends Usecase<String, ResetPasswordParams> {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, String>> call([ResetPasswordParams? params]) async {
    return await authRepo.resetPassword(
      email: params!.email,
      otp: params.otp,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}

class ResetPasswordParams {
  final String email;
  final String otp;
  final String password;
  final String passwordConfirmation;

  ResetPasswordParams({
    required this.email,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });
}
