import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor_schedule.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_day_off.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_schedules_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_schedule_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/get_days_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/create_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/delete_day_off_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_schedule_cubit.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/profile/doctor_schedule_state.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_profile_repo.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetSchedulesUseCase implements GetSchedulesUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, List<DoctorSchedule>>? resultToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, List<DoctorSchedule>>> call() async {
    callCount++;
    return resultToReturn ?? const Right([]);
  }
}

class MockUpdateScheduleUseCase implements UpdateScheduleUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, DoctorSchedule>? resultToReturn;
  int callCount = 0;
  int? lastId;

  @override
  Future<Either<Failure, DoctorSchedule>> call({
    required int id,
    required String startTime,
    required String endTime,
  }) async {
    callCount++;
    lastId = id;
    return resultToReturn ?? Right(makeFakeDoctorSchedule(id: id));
  }
}

class MockGetDaysOffUseCase implements GetDaysOffUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, List<DoctorDayOff>>? resultToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, List<DoctorDayOff>>> call() async {
    callCount++;
    return resultToReturn ?? const Right([]);
  }
}

class MockCreateDayOffUseCase implements CreateDayOffUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, List<DoctorDayOff>>? resultToReturn;
  int callCount = 0;
  List<int>? lastDayIds;

  @override
  Future<Either<Failure, List<DoctorDayOff>>> call(List<int> dayIds) async {
    callCount++;
    lastDayIds = dayIds;
    return resultToReturn ?? const Right([]);
  }
}

class MockDeleteDayOffUseCase implements DeleteDayOffUseCase {
  @override
  late DoctorProfileRepo repo;

  Either<Failure, void>? resultToReturn;
  int callCount = 0;
  int? lastId;

  @override
  Future<Either<Failure, void>> call(int id) async {
    callCount++;
    lastId = id;
    return resultToReturn ?? const Right(null);
  }
}

DoctorSchedule makeFakeDoctorSchedule({required int id}) {
  return DoctorSchedule(
    id: id,
    doctorId: 10,
    dayId: 1,
    startTime: '09:00',
    endTime: '17:00',
  );
}

void main() {
  late MockGetSchedulesUseCase mockGetSchedulesUseCase;
  late MockUpdateScheduleUseCase mockUpdateScheduleUseCase;
  late MockGetDaysOffUseCase mockGetDaysOffUseCase;
  late MockCreateDayOffUseCase mockCreateDayOffUseCase;
  late MockDeleteDayOffUseCase mockDeleteDayOffUseCase;
  late DoctorScheduleCubit cubit;

  setUp(() {
    mockGetSchedulesUseCase = MockGetSchedulesUseCase();
    mockUpdateScheduleUseCase = MockUpdateScheduleUseCase();
    mockGetDaysOffUseCase = MockGetDaysOffUseCase();
    mockCreateDayOffUseCase = MockCreateDayOffUseCase();
    mockDeleteDayOffUseCase = MockDeleteDayOffUseCase();

    cubit = DoctorScheduleCubit(
      getSchedulesUseCase: mockGetSchedulesUseCase,
      updateScheduleUseCase: mockUpdateScheduleUseCase,
      getDaysOffUseCase: mockGetDaysOffUseCase,
      createDayOffUseCase: mockCreateDayOffUseCase,
      deleteDayOffUseCase: mockDeleteDayOffUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is DoctorScheduleInitial', () {
    expect(cubit.state, isA<DoctorScheduleInitial>());
  });

  group('fetchAll', () {
    test('emits [Loading, Loaded] on success', () async {
      final schedules = <DoctorSchedule>[];
      final daysOff = <DoctorDayOff>[];
      mockGetSchedulesUseCase.resultToReturn = Right(schedules);
      mockGetDaysOffUseCase.resultToReturn = Right(daysOff);

      final states = <DoctorScheduleState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.fetchAll();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorScheduleLoading>());
      expect(states[1], isA<DoctorScheduleLoaded>());
      expect((states[1] as DoctorScheduleLoaded).schedules, schedules);
      expect((states[1] as DoctorScheduleLoaded).daysOff, daysOff);

      await sub.cancel();
    });
  });
}
