import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class VerifyOtpUseCase extends Usecase<String, VerifyOtpParams> {
  final AuthRepo authRepo;

  VerifyOtpUseCase(this.authRepo);

  @override
  Future<Either<Failure, String>> call([VerifyOtpParams? params]) async {
    return await authRepo.verifyOtp(params!.email, params.otp);
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;

  VerifyOtpParams({required this.email, required this.otp});
}
