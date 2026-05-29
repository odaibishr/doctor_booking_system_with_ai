import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/specialty.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/specialty_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_all_specialties_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/specialty/specialty_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockWatchSpecialtiesUseCase implements WatchSpecialtiesUseCase {
  @override
  late SpecialtyRepo specialtyRepo;

  Stream<Either<Failure, List<Specialty>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<Specialty>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshSpecialtiesUseCase implements RefreshSpecialtiesUseCase {
  @override
  late SpecialtyRepo specialtyRepo;

  Future<void>? futureToReturn;
  int callCount = 0;

  @override
  Future<void> call() async {
    callCount++;
    return futureToReturn ?? Future.value();
  }
}

class MockWatchAllSpecialtiesUseCase implements WatchAllSpecialtiesUseCase {
  @override
  late SpecialtyRepo specialtyRepo;

  Stream<Either<Failure, List<Specialty>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<Specialty>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshAllSpecialtiesUseCase implements RefreshAllSpecialtiesUseCase {
  @override
  late SpecialtyRepo specialtyRepo;

  Future<void>? futureToReturn;
  int callCount = 0;

  @override
  Future<void> call() async {
    callCount++;
    return futureToReturn ?? Future.value();
  }
}

// Minimal stub for Specialty
class FakeSpecialty implements Specialty {
  @override
  int id = 1;
  @override
  String name = "Test Specialty";
  @override
  String icon = "test_icon.png";
  @override
  bool isActive = true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockWatchSpecialtiesUseCase mockWatchSpecialtiesUseCase;
  late MockRefreshSpecialtiesUseCase mockRefreshSpecialtiesUseCase;
  late MockWatchAllSpecialtiesUseCase mockWatchAllSpecialtiesUseCase;
  late MockRefreshAllSpecialtiesUseCase mockRefreshAllSpecialtiesUseCase;
  late SpecialtyCubit specialtyCubit;

  setUp(() {
    mockWatchSpecialtiesUseCase = MockWatchSpecialtiesUseCase();
    mockRefreshSpecialtiesUseCase = MockRefreshSpecialtiesUseCase();
    mockWatchAllSpecialtiesUseCase = MockWatchAllSpecialtiesUseCase();
    mockRefreshAllSpecialtiesUseCase = MockRefreshAllSpecialtiesUseCase();
    specialtyCubit = SpecialtyCubit(
      watchSpecialtiesUseCase: mockWatchSpecialtiesUseCase,
      refreshSpecialtiesUseCase: mockRefreshSpecialtiesUseCase,
      watchAllSpecialtiesUseCase: mockWatchAllSpecialtiesUseCase,
      refreshAllSpecialtiesUseCase: mockRefreshAllSpecialtiesUseCase,
    );
  });

  tearDown(() {
    specialtyCubit.close();
  });

  test('initial state should be SpecialtyInitial', () {
    expect(specialtyCubit.state, isA<SpecialtyInitial>());
  });

  group('getSpecialties (stream watching)', () {
    test('emits [SpecialtyLoading, SpecialtyLoaded] when stream yields specialties successfully', () async {
      final fakeSpecialties = [FakeSpecialty()];
      mockWatchSpecialtiesUseCase.streamToReturn = Stream.value(Right(fakeSpecialties));

      final states = <SpecialtyState>[];
      final subscription = specialtyCubit.stream.listen(states.add);

      await specialtyCubit.getSpecialties();

      // Allow microtask queue to process stream updates
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<SpecialtyLoading>());
      expect(states[1], isA<SpecialtyLoaded>());

      final loadedState = states[1] as SpecialtyLoaded;
      expect(loadedState.specialties, fakeSpecialties);
      expect(mockWatchSpecialtiesUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [SpecialtyLoading, SpecialtyError] when stream yields Failure', () async {
      mockWatchSpecialtiesUseCase.streamToReturn = Stream.value(Left(Failure('Error occurred')));

      final states = <SpecialtyState>[];
      final subscription = specialtyCubit.stream.listen(states.add);

      await specialtyCubit.getSpecialties();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<SpecialtyLoading>());
      expect(states[1], isA<SpecialtyError>());

      final errorState = states[1] as SpecialtyError;
      expect(errorState.message, 'Error occurred');

      await subscription.cancel();
    });

    test('getSpecialties forceRefresh calls refreshSpecialtiesUseCase and does not emit watch states', () async {
      await specialtyCubit.getSpecialties(forceRefresh: true);

      expect(mockRefreshSpecialtiesUseCase.callCount, 1);
      expect(mockWatchSpecialtiesUseCase.callCount, 0);
    });
  });

  group('getAllSpecialties (stream watching)', () {
    test('emits [SpecialtyLoading, SpecialtyLoaded] when stream yields all specialties successfully', () async {
      final fakeSpecialties = [FakeSpecialty()];
      mockWatchAllSpecialtiesUseCase.streamToReturn = Stream.value(Right(fakeSpecialties));

      final states = <SpecialtyState>[];
      final subscription = specialtyCubit.stream.listen(states.add);

      await specialtyCubit.getAllSpecialties();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<SpecialtyLoading>());
      expect(states[1], isA<SpecialtyLoaded>());

      final loadedState = states[1] as SpecialtyLoaded;
      expect(loadedState.specialties, fakeSpecialties);
      expect(mockWatchAllSpecialtiesUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('getAllSpecialties forceRefresh calls refreshAllSpecialtiesUseCase', () async {
      await specialtyCubit.getAllSpecialties(forceRefresh: true);

      expect(mockRefreshAllSpecialtiesUseCase.callCount, 1);
      expect(mockWatchAllSpecialtiesUseCase.callCount, 0);
    });
  });
}
