import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/watch_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/domain/use_cases/refresh_favorite_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/favorite_doctor/presentation/manager/favorite_doctor_cubit/favorite_doctor_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockWatchFavoriteDoctorsUseCase implements WatchFavoriteDoctorsUseCase {
  @override
  late DoctorRepo doctorRepo;

  Stream<Either<Failure, List<Doctor>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<Doctor>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshFavoriteDoctorsUseCase implements RefreshFavoriteDoctorsUseCase {
  @override
  late DoctorRepo doctorRepo;

  Future<void>? futureToReturn;
  int callCount = 0;

  @override
  Future<void> call() async {
    callCount++;
    return futureToReturn ?? Future.value();
  }
}

// Minimal stub for Doctor
class FakeDoctor implements Doctor {
  @override
  int id = 1;
  @override
  String name = "Dr. Test";
  @override
  String aboutus = "about";
  @override
  int specialtyId = 1;
  @override
  int hospitalId = 1;
  @override
  int isFeatured = 1;
  @override
  int isTopDoctor = 1;
  @override
  List<String> services = const [];
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockWatchFavoriteDoctorsUseCase mockWatchFavoriteDoctorsUseCase;
  late MockRefreshFavoriteDoctorsUseCase mockRefreshFavoriteDoctorsUseCase;
  late FavoriteDoctorCubit favoriteDoctorCubit;

  setUp(() {
    mockWatchFavoriteDoctorsUseCase = MockWatchFavoriteDoctorsUseCase();
    mockRefreshFavoriteDoctorsUseCase = MockRefreshFavoriteDoctorsUseCase();
    favoriteDoctorCubit = FavoriteDoctorCubit(
      watchFavoriteDoctorsUseCase: mockWatchFavoriteDoctorsUseCase,
      refreshFavoriteDoctorsUseCase: mockRefreshFavoriteDoctorsUseCase,
    );
  });

  tearDown(() {
    favoriteDoctorCubit.close();
  });

  test('initial state should be FavoriteDoctorInitial', () {
    expect(favoriteDoctorCubit.state, isA<FavoriteDoctorInitial>());
  });

  group('getFavoriteDoctors', () {
    test('emits [FavoirteDoctorsLoading, FavoriteDoctorsLoaded] on successful stream yield', () async {
      final fakeDoctors = [FakeDoctor()];
      mockWatchFavoriteDoctorsUseCase.streamToReturn = Stream.value(Right(fakeDoctors));

      final states = <FavoriteDoctorState>[];
      final subscription = favoriteDoctorCubit.stream.listen(states.add);

      await favoriteDoctorCubit.getFavoriteDoctors();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<FavoirteDoctorsLoading>());
      expect(states[1], isA<FavoriteDoctorsLoaded>());

      final loadedState = states[1] as FavoriteDoctorsLoaded;
      expect(loadedState.doctors, fakeDoctors);
      expect(mockWatchFavoriteDoctorsUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [FavoirteDoctorsLoading, FavoriteDoctorsError] on failure stream yield', () async {
      mockWatchFavoriteDoctorsUseCase.streamToReturn = Stream.value(Left(Failure('Fetch failed')));

      final states = <FavoriteDoctorState>[];
      final subscription = favoriteDoctorCubit.stream.listen(states.add);

      await favoriteDoctorCubit.getFavoriteDoctors();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<FavoirteDoctorsLoading>());
      expect(states[1], isA<FavoriteDoctorsError>());

      final errorState = states[1] as FavoriteDoctorsError;
      expect(errorState.message, 'Fetch failed');

      await subscription.cancel();
    });

    test('forceRefresh calls refreshFavoriteDoctorsUseCase and does not emit watch states', () async {
      await favoriteDoctorCubit.getFavoriteDoctors(forceRefresh: true);

      expect(mockRefreshFavoriteDoctorsUseCase.callCount, 1);
      expect(mockWatchFavoriteDoctorsUseCase.callCount, 0);
    });
  });
}
