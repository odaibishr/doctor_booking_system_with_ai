import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/hospital.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/hospital_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_hospitals_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/manager/hospital/hospital_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockWatchHospitalsUseCase implements WatchHospitalsUseCase {
  @override
  late HospitalRepo hospitalRepo;

  Stream<Either<Failure, List<Hospital>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<Hospital>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshHospitalsUseCase implements RefreshHospitalsUseCase {
  @override
  late HospitalRepo hospitalRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, void>> call() async {
    callCount++;
    return futureToReturn ?? const Right(null);
  }
}

// Minimal stub for Hospital
class FakeHospital implements Hospital {
  @override
  int id = 1;
  @override
  String name = "Test Hospital";

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockWatchHospitalsUseCase mockWatchHospitalsUseCase;
  late MockRefreshHospitalsUseCase mockRefreshHospitalsUseCase;
  late HospitalCubit hospitalCubit;

  setUp(() {
    mockWatchHospitalsUseCase = MockWatchHospitalsUseCase();
    mockRefreshHospitalsUseCase = MockRefreshHospitalsUseCase();
    hospitalCubit = HospitalCubit(
      watchHospitalsUseCase: mockWatchHospitalsUseCase,
      refreshHospitalsUseCase: mockRefreshHospitalsUseCase,
    );
  });

  tearDown(() {
    hospitalCubit.close();
  });

  test('initial state should be HospitalInitial', () {
    expect(hospitalCubit.state, isA<HospitalInitial>());
  });

  group('getHospitals (stream watching)', () {
    test('emits [HospitalLoading, HospitalLoadded] when stream yields hospitals successfully', () async {
      final fakeHospitals = [FakeHospital()];
      mockWatchHospitalsUseCase.streamToReturn = Stream.value(Right(fakeHospitals));

      final states = <HospitalState>[];
      final subscription = hospitalCubit.stream.listen(states.add);

      await hospitalCubit.getHospitals();

      // Allow microtask queue to process stream updates
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<HospitalLoading>());
      expect(states[1], isA<HospitalLoadded>());

      final loadedState = states[1] as HospitalLoadded;
      expect(loadedState.hospitals, fakeHospitals);
      expect(mockWatchHospitalsUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [HospitalLoading, HospitalError] when stream yields Failure', () async {
      mockWatchHospitalsUseCase.streamToReturn = Stream.value(Left(Failure('Error occurred')));

      final states = <HospitalState>[];
      final subscription = hospitalCubit.stream.listen(states.add);

      await hospitalCubit.getHospitals();

      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<HospitalLoading>());
      expect(states[1], isA<HospitalError>());

      final errorState = states[1] as HospitalError;
      expect(errorState.message, 'Error occurred');

      await subscription.cancel();
    });

    test('emits [HospitalLoading, HospitalError] when stream throws error', () async {
      mockWatchHospitalsUseCase.streamToReturn = Stream.error('Stream error');

      final states = <HospitalState>[];
      final subscription = hospitalCubit.stream.listen(states.add);

      await hospitalCubit.getHospitals();

      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<HospitalLoading>());
      expect(states[1], isA<HospitalError>());

      final errorState = states[1] as HospitalError;
      expect(errorState.message, 'Stream error');

      await subscription.cancel();
    });
  });

  group('getHospitals forceRefresh', () {
    test('calls refreshHospitalsUseCase and does not emit watch states', () async {
      mockRefreshHospitalsUseCase.futureToReturn = Future.value(const Right(null));

      final states = <HospitalState>[];
      final subscription = hospitalCubit.stream.listen(states.add);

      await hospitalCubit.getHospitals(forceRefresh: true);

      await Future.delayed(Duration.zero);

      expect(states.isEmpty, true);
      expect(mockRefreshHospitalsUseCase.callCount, 1);
      expect(mockWatchHospitalsUseCase.callCount, 0);

      await subscription.cancel();
    });
  });
}
