import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/review.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/review_repo.dart';
import 'package:doctor_booking_system_with_ai/core/usecases/usecase.dart';

class GetDoctorReviewsUseCase
    extends Usecase<List<Review>, GetDoctorReviewsParams> {
  final ReviewRepo reviewRepo;
  GetDoctorReviewsUseCase(this.reviewRepo);

  @override
  Future<Either<Failure, List<Review>>> call([
    GetDoctorReviewsParams? params,
  ]) async {
    return await reviewRepo.getDoctorReviews(params!.doctorId);
  }
}

class GetDoctorReviewsParams {
  final int doctorId;

  GetDoctorReviewsParams(this.doctorId);
}
