import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/entities/notification_entity.dart';
import 'package:doctor_booking_system_with_ai/features/notification/domain/repos/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    int page = 1,
  }) async {
    try {
      final result = await _remoteDataSource.getNotifications(page: page);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int id) async {
    try {
      await _remoteDataSource.markAsRead(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await _remoteDataSource.markAllAsRead();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final count = await _remoteDataSource.getUnreadCount();
      return Right(count);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
