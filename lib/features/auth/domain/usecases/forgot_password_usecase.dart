import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/auth/domain/repos/auth_repo.dart';

class ForgotPasswordUseCase extends Usecase<String, String> {
  final AuthRepo authRepo;

  ForgotPasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, String>> call([String? email]) async {
    return await authRepo.forgotPassword(email!);
  }
}
