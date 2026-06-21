import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/repos/doctor_repo.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/watch_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/refresh_doctor_details_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/home/presentation/manager/doctor_details/doctor_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockWatchDoctorDetailsUseCase implements WatchDoctorDetailsUseCase {
  @override
  late DoctorRepo doctorRepo;

  Stream<Either<Failure, Doctor>>? streamToReturn;
  int callCount = 0;
  int? lastId;

  @override
  Stream<Either<Failure, Doctor>> call(int id) {
    callCount++;
    lastId = id;
    return streamToReturn ?? Stream.value(Left(Failure('Not mocked')));
  }
}

class MockRefreshDoctorDetailsUseCase implements RefreshDoctorDetailsUseCase {
  @override
  late DoctorRepo doctorRepo;

  Future<void>? futureToReturn;
  int callCount = 0;
  int? lastId;

  @override
  Future<void> call(int id) async {
    callCount++;
    lastId = id;
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
  late MockWatchDoctorDetailsUseCase mockWatchDoctorDetailsUseCase;
  late MockRefreshDoctorDetailsUseCase mockRefreshDoctorDetailsUseCase;
  late DoctorDetailsCubit doctorDetailsCubit;

  setUp(() {
    mockWatchDoctorDetailsUseCase = MockWatchDoctorDetailsUseCase();
    mockRefreshDoctorDetailsUseCase = MockRefreshDoctorDetailsUseCase();
    doctorDetailsCubit = DoctorDetailsCubit(
      watchDoctorDetailsUseCase: mockWatchDoctorDetailsUseCase,
      refreshDoctorDetailsUseCase: mockRefreshDoctorDetailsUseCase,
    );
  });

  tearDown(() {
    doctorDetailsCubit.close();
  });

  test('initial state should be DoctorDetailsInitial', () {
    expect(doctorDetailsCubit.state, isA<DoctorDetailsInitial>());
  });

  group('getDoctorsDetails', () {
    test('emits [DoctorDetailsLoading, DoctorDetailsLoaded] on successful stream yield', () async {
      final fakeDoctor = FakeDoctor();
      mockWatchDoctorDetailsUseCase.streamToReturn = Stream.value(Right(fakeDoctor));

      final states = <DoctorDetailsState>[];
      final subscription = doctorDetailsCubit.stream.listen(states.add);

      await doctorDetailsCubit.getDoctorsDetails(10);
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorDetailsLoading>());
      expect(states[1], isA<DoctorDetailsLoaded>());

      final loadedState = states[1] as DoctorDetailsLoaded;
      expect(loadedState.doctor, fakeDoctor);
      expect(mockWatchDoctorDetailsUseCase.callCount, 1);
      expect(mockWatchDoctorDetailsUseCase.lastId, 10);

      await subscription.cancel();
    });

    test('emits [DoctorDetailsLoading, DoctorDetailsError] on failure stream yield', () async {
      mockWatchDoctorDetailsUseCase.streamToReturn = Stream.value(Left(Failure('Fetch failed')));

      final states = <DoctorDetailsState>[];
      final subscription = doctorDetailsCubit.stream.listen(states.add);

      await doctorDetailsCubit.getDoctorsDetails(10);
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorDetailsLoading>());
      expect(states[1], isA<DoctorDetailsError>());

      final errorState = states[1] as DoctorDetailsError;
      expect(errorState.message, 'Fetch failed');

      await subscription.cancel();
    });

    test('forceRefresh calls refreshDoctorDetailsUseCase and does not emit watch states', () async {
      await doctorDetailsCubit.getDoctorsDetails(10, forceRefresh: true);

      expect(mockRefreshDoctorDetailsUseCase.callCount, 1);
      expect(mockRefreshDoctorDetailsUseCase.lastId, 10);
      expect(mockWatchDoctorDetailsUseCase.callCount, 0);
    });
  });
}
