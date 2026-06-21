import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_my_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_profile_image_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_profile_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_profile_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetMyProfileUseCase implements GetMyProfileUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, Doctor>? resultToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, Doctor>> call() async {
    callCount++;
    return resultToReturn ?? Right(FakeDoctor());
  }
}

class MockUpdateProfileUseCase implements UpdateProfileUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, Doctor>? resultToReturn;
  int callCount = 0;
  Map<String, dynamic>? lastData;

  @override
  Future<Either<Failure, Doctor>> call(Map<String, dynamic> data) async {
    callCount++;
    lastData = data;
    return resultToReturn ?? Right(FakeDoctor());
  }
}

class MockUpdateProfileImageUseCase implements UpdateProfileImageUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, String>? resultToReturn;
  int callCount = 0;
  File? lastFile;

  @override
  Future<Either<Failure, String>> call(File imageFile) async {
    callCount++;
    lastFile = imageFile;
    return resultToReturn ?? const Right('new_image_path.jpg');
  }
}

class FakeDoctor implements Doctor {
  @override
  int id = 1;
  @override
  String name = 'Test Doctor';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockGetMyProfileUseCase mockGetMyProfileUseCase;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockUpdateProfileImageUseCase mockUpdateProfileImageUseCase;
  late DoctorProfileCubit cubit;

  setUp(() {
    mockGetMyProfileUseCase = MockGetMyProfileUseCase();
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    mockUpdateProfileImageUseCase = MockUpdateProfileImageUseCase();

    cubit = DoctorProfileCubit(
      getMyProfileUseCase: mockGetMyProfileUseCase,
      updateProfileUseCase: mockUpdateProfileUseCase,
      updateProfileImageUseCase: mockUpdateProfileImageUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is DoctorProfileInitial', () {
    expect(cubit.state, isA<DoctorProfileInitial>());
  });

  group('fetchProfile', () {
    test('emits [Loading, Loaded] on success', () async {
      final doctor = FakeDoctor();
      mockGetMyProfileUseCase.resultToReturn = Right(doctor);

      final states = <DoctorProfileState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchProfile();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorProfileLoading>());
      expect(states[1], isA<DoctorProfileLoaded>());
      expect((states[1] as DoctorProfileLoaded).doctor, doctor);

      await sub.cancel();
    });

    test('emits [Loading, Error] on failure', () async {
      mockGetMyProfileUseCase.resultToReturn = Left(Failure('Error fetching profile'));

      final states = <DoctorProfileState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchProfile();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorProfileLoading>());
      expect(states[1], isA<DoctorProfileError>());
      expect((states[1] as DoctorProfileError).message, 'Error fetching profile');

      await sub.cancel();
    });
  });

  group('updateProfile', () {
    test('emits [Updating, Loaded] on success', () async {
      final doctor = FakeDoctor();
      mockUpdateProfileUseCase.resultToReturn = Right(doctor);

      final states = <DoctorProfileState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.updateProfile({'name': 'New Name'});
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorProfileUpdating>());
      expect(states[1], isA<DoctorProfileLoaded>());
      expect(mockUpdateProfileUseCase.lastData, {'name': 'New Name'});

      await sub.cancel();
    });
  });
}
