import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctors_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor/doctor_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockWatchDoctorsUseCase implements WatchDoctorsUseCase {
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

class MockRefreshDoctorsUseCase implements RefreshDoctorsUseCase {
  @override
  late DoctorRepo doctorRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, void>> call() async {
    callCount++;
    return futureToReturn ?? const Right(null);
  }
}

// Minimal stub for Doctor
class FakeDoctor implements Doctor {
  @override
  int id = 1;
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
  late MockWatchDoctorsUseCase mockWatchDoctorsUseCase;
  late MockRefreshDoctorsUseCase mockRefreshDoctorsUseCase;
  late DoctorCubit doctorCubit;

  setUp(() {
    mockWatchDoctorsUseCase = MockWatchDoctorsUseCase();
    mockRefreshDoctorsUseCase = MockRefreshDoctorsUseCase();
    doctorCubit = DoctorCubit(
      watchDoctorsUseCase: mockWatchDoctorsUseCase,
      refreshDoctorsUseCase: mockRefreshDoctorsUseCase,
    );
  });

  tearDown(() {
    doctorCubit.close();
  });

  test('initial state should be DoctorInitial', () {
    expect(doctorCubit.state, isA<DoctorInitial>());
  });

  group('fetchDoctors (stream watching)', () {
    test('emits [DoctorsLoading, DoctorsLoaded] when stream yields doctors successfully', () async {
      final fakeDoctors = [FakeDoctor()];
      mockWatchDoctorsUseCase.streamToReturn = Stream.value(Right(fakeDoctors));

      final states = <DoctorState>[];
      final subscription = doctorCubit.stream.listen(states.add);

      await doctorCubit.fetchDoctors();
      
      // Allow microtask queue to process stream updates
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorsLoading>());
      expect(states[1], isA<DoctorsLoaded>());
      
      final loadedState = states[1] as DoctorsLoaded;
      expect(loadedState.doctors, fakeDoctors);
      expect(mockWatchDoctorsUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [DoctorsLoading, DoctorsError] when stream yields Failure', () async {
      mockWatchDoctorsUseCase.streamToReturn = Stream.value(Left(ServerFailure('Server error occurred')));

      final states = <DoctorState>[];
      final subscription = doctorCubit.stream.listen(states.add);

      await doctorCubit.fetchDoctors();

      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorsLoading>());
      expect(states[1], isA<DoctorsError>());

      final errorState = states[1] as DoctorsError;
      expect(errorState.message, 'Server error occurred');

      await subscription.cancel();
    });

    test('emits [DoctorsLoading, DoctorsError] when stream throws error', () async {
      mockWatchDoctorsUseCase.streamToReturn = Stream.error('Stream error');

      final states = <DoctorState>[];
      final subscription = doctorCubit.stream.listen(states.add);

      await doctorCubit.fetchDoctors();

      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorsLoading>());
      expect(states[1], isA<DoctorsError>());

      final errorState = states[1] as DoctorsError;
      expect(errorState.message, 'Stream error');

      await subscription.cancel();
    });
  });

  group('fetchDoctors forceRefresh', () {
    test('calls refreshDoctorsUseCase and does not emit watch states', () async {
      mockRefreshDoctorsUseCase.futureToReturn = Future.value(const Right(null));

      final states = <DoctorState>[];
      final subscription = doctorCubit.stream.listen(states.add);

      await doctorCubit.fetchDoctors(forceRefresh: true);

      await Future.delayed(Duration.zero);

      expect(states.isEmpty, true);
      expect(mockRefreshDoctorsUseCase.callCount, 1);
      expect(mockWatchDoctorsUseCase.callCount, 0);

      await subscription.cancel();
    });
  });
}
