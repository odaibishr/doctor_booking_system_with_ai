import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';
import 'package:doctor_booking_system_with_ai/features/profile/domain/repos/logout_repo.dart';

class LogoutUseCase extends Usecase<void, NoParams> {
  final LogoutRepo logoutRepo;
  LogoutUseCase(this.logoutRepo);

  @override
  Future<Either<Failure, void>> call([NoParams? params]) {
    return logoutRepo.logout();
  }
}

class NoParams {}
