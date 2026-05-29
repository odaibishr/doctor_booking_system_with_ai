import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/doctor_appointment.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_appointment_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/update_appointment_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_today_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_upcoming_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_history_appointments_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_appointments_by_status_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/managers/appointments/doctor_appointments_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks
class MockUpdateAppointmentStatusUseCase implements UpdateAppointmentStatusUseCase {
  @override
  late DoctorAppointmentRepo repo;

  Either<Failure, DoctorAppointment>? resultToReturn;
  int callCount = 0;
  UpdateAppointmentStatusUseCaseParams? lastParams;

  @override
  Future<Either<Failure, DoctorAppointment>> call([UpdateAppointmentStatusUseCaseParams? params]) async {
    callCount++;
    lastParams = params;
    return resultToReturn ?? Right(DoctorAppointment(
      id: params?.id ?? 1,
      doctorId: 10,
      userId: 100,
      doctorScheduleId: 200,
      date: '2026-05-29',
      status: params?.status ?? 'pending',
      isCompleted: false,
      createdAt: '2026-05-29T00:00:00Z',
      updatedAt: '2026-05-29T00:00:00Z',
    ));
  }
}

class MockWatchTodayAppointmentsUseCase implements WatchTodayAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Stream<Either<Failure, List<DoctorAppointment>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshTodayAppointmentsUseCase implements RefreshTodayAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, void>> call() async {
    callCount++;
    return futureToReturn ?? Future.value(const Right(null));
  }
}

class MockWatchUpcomingAppointmentsUseCase implements WatchUpcomingAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Stream<Either<Failure, List<DoctorAppointment>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshUpcomingAppointmentsUseCase implements RefreshUpcomingAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, void>> call() async {
    callCount++;
    return futureToReturn ?? Future.value(const Right(null));
  }
}

class MockWatchHistoryAppointmentsUseCase implements WatchHistoryAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Stream<Either<Failure, List<DoctorAppointment>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshHistoryAppointmentsUseCase implements RefreshHistoryAppointmentsUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;

  @override
  Future<Either<Failure, void>> call() async {
    callCount++;
    return futureToReturn ?? Future.value(const Right(null));
  }
}

class MockWatchAppointmentsByStatusUseCase implements WatchAppointmentsByStatusUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Stream<Either<Failure, List<DoctorAppointment>>>? streamToReturn;
  int callCount = 0;
  String? lastStatus;

  @override
  Stream<Either<Failure, List<DoctorAppointment>>> call(String status) {
    callCount++;
    lastStatus = status;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshAppointmentsByStatusUseCase implements RefreshAppointmentsByStatusUseCase {
  @override
  late DoctorAppointmentRepo doctorAppointmentRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;
  String? lastStatus;

  @override
  Future<Either<Failure, void>> call(String status) async {
    callCount++;
    lastStatus = status;
    return futureToReturn ?? Future.value(const Right(null));
  }
}

class MockPusherService implements PusherService {
  final StreamController<Map<String, dynamic>> _controller = StreamController<Map<String, dynamic>>.broadcast();

  @override
  Stream<Map<String, dynamic>> get eventStream => _controller.stream;

  void triggerEvent(Map<String, dynamic> event) {
    _controller.add(event);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockFcmService implements FcmService {
  final StreamController<Map<String, dynamic>> _controller = StreamController<Map<String, dynamic>>.broadcast();

  @override
  Stream<Map<String, dynamic>> get eventStream => _controller.stream;

  void triggerEvent(Map<String, dynamic> event) {
    _controller.add(event);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DoctorAppointment makeFakeAppointment({int id = 1, String status = 'pending'}) {
  return DoctorAppointment(
    id: id,
    doctorId: 10,
    userId: 100,
    doctorScheduleId: 200,
    date: '2026-05-29',
    status: status,
    isCompleted: false,
    createdAt: '2026-05-29T00:00:00Z',
    updatedAt: '2026-05-29T00:00:00Z',
  );
}

void main() {
  late MockUpdateAppointmentStatusUseCase mockUpdateAppointmentStatusUseCase;
  late MockWatchTodayAppointmentsUseCase mockWatchTodayAppointmentsUseCase;
  late MockRefreshTodayAppointmentsUseCase mockRefreshTodayAppointmentsUseCase;
  late MockWatchUpcomingAppointmentsUseCase mockWatchUpcomingAppointmentsUseCase;
  late MockRefreshUpcomingAppointmentsUseCase mockRefreshUpcomingAppointmentsUseCase;
  late MockWatchHistoryAppointmentsUseCase mockWatchHistoryAppointmentsUseCase;
  late MockRefreshHistoryAppointmentsUseCase mockRefreshHistoryAppointmentsUseCase;
  late MockWatchAppointmentsByStatusUseCase mockWatchAppointmentsByStatusUseCase;
  late MockRefreshAppointmentsByStatusUseCase mockRefreshAppointmentsByStatusUseCase;
  late MockPusherService mockPusherService;
  late MockFcmService mockFcmService;
  late DoctorAppointmentsCubit cubit;

  setUp(() {
    mockUpdateAppointmentStatusUseCase = MockUpdateAppointmentStatusUseCase();
    mockWatchTodayAppointmentsUseCase = MockWatchTodayAppointmentsUseCase();
    mockRefreshTodayAppointmentsUseCase = MockRefreshTodayAppointmentsUseCase();
    mockWatchUpcomingAppointmentsUseCase = MockWatchUpcomingAppointmentsUseCase();
    mockRefreshUpcomingAppointmentsUseCase = MockRefreshUpcomingAppointmentsUseCase();
    mockWatchHistoryAppointmentsUseCase = MockWatchHistoryAppointmentsUseCase();
    mockRefreshHistoryAppointmentsUseCase = MockRefreshHistoryAppointmentsUseCase();
    mockWatchAppointmentsByStatusUseCase = MockWatchAppointmentsByStatusUseCase();
    mockRefreshAppointmentsByStatusUseCase = MockRefreshAppointmentsByStatusUseCase();
    mockPusherService = MockPusherService();
    mockFcmService = MockFcmService();

    cubit = DoctorAppointmentsCubit(
      updateAppointmentStatusUseCase: mockUpdateAppointmentStatusUseCase,
      watchTodayAppointmentsUseCase: mockWatchTodayAppointmentsUseCase,
      refreshTodayAppointmentsUseCase: mockRefreshTodayAppointmentsUseCase,
      watchUpcomingAppointmentsUseCase: mockWatchUpcomingAppointmentsUseCase,
      refreshUpcomingAppointmentsUseCase: mockRefreshUpcomingAppointmentsUseCase,
      watchHistoryAppointmentsUseCase: mockWatchHistoryAppointmentsUseCase,
      refreshHistoryAppointmentsUseCase: mockRefreshHistoryAppointmentsUseCase,
      watchAppointmentsByStatusUseCase: mockWatchAppointmentsByStatusUseCase,
      refreshAppointmentsByStatusUseCase: mockRefreshAppointmentsByStatusUseCase,
      pusherService: mockPusherService,
      fcmService: mockFcmService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is DoctorAppointmentsInitial', () {
    expect(cubit.state, isA<DoctorAppointmentsInitial>());
  });

  group('fetchToday', () {
    test('emits [Loading, Loaded] on success stream yield', () async {
      final appointments = [makeFakeAppointment(id: 1, status: 'confirmed')];
      mockWatchTodayAppointmentsUseCase.streamToReturn = Stream.value(Right(appointments));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchToday();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorAppointmentsLoading>());
      expect(states[1], isA<DoctorAppointmentsLoaded>());
      expect((states[1] as DoctorAppointmentsLoaded).appointments, appointments);

      await sub.cancel();
    });

    test('emits [Loading, Error] on failure stream yield', () async {
      mockWatchTodayAppointmentsUseCase.streamToReturn = Stream.value(Left(Failure('Fetch failed')));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchToday();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorAppointmentsLoading>());
      expect(states[1], isA<DoctorAppointmentsError>());
      expect((states[1] as DoctorAppointmentsError).message, 'Fetch failed');

      await sub.cancel();
    });
  });

  group('fetchUpcoming', () {
    test('emits [Loading, Loaded] on success stream yield', () async {
      final appointments = [makeFakeAppointment(id: 2, status: 'pending')];
      mockWatchUpcomingAppointmentsUseCase.streamToReturn = Stream.value(Right(appointments));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchUpcoming();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorAppointmentsLoading>());
      expect(states[1], isA<DoctorAppointmentsLoaded>());

      await sub.cancel();
    });
  });

  group('fetchHistory', () {
    test('emits [Loading, Loaded] on success stream yield', () async {
      final appointments = [makeFakeAppointment(id: 3, status: 'completed')];
      mockWatchHistoryAppointmentsUseCase.streamToReturn = Stream.value(Right(appointments));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchHistory();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorAppointmentsLoading>());
      expect(states[1], isA<DoctorAppointmentsLoaded>());

      await sub.cancel();
    });
  });

  group('fetchAppointmentsByStatus', () {
    test('emits [Loading, Loaded] on success stream yield', () async {
      final appointments = [makeFakeAppointment(id: 4, status: 'cancelled')];
      mockWatchAppointmentsByStatusUseCase.streamToReturn = Stream.value(Right(appointments));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchAppointmentsByStatus('cancelled');
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorAppointmentsLoading>());
      expect(states[1], isA<DoctorAppointmentsLoaded>());
      expect(mockWatchAppointmentsByStatusUseCase.lastStatus, 'cancelled');

      await sub.cancel();
    });
  });

  group('updateAppointmentStatus', () {
    test('emits [DoctorAppointmentStatusUpdated] on success and triggers active refresh', () async {
      final updated = makeFakeAppointment(id: 1, status: 'confirmed');
      mockUpdateAppointmentStatusUseCase.resultToReturn = Right(updated);

      // set up an active refresh by calling fetchToday
      cubit.fetchToday();
      await Future.delayed(Duration.zero);

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.updateAppointmentStatus(id: 1, status: 'confirmed');
      await Future.delayed(Duration.zero);

      expect(states.length, 1);
      expect(states[0], isA<DoctorAppointmentStatusUpdated>());
      expect((states[0] as DoctorAppointmentStatusUpdated).appointment, updated);
      expect(mockRefreshTodayAppointmentsUseCase.callCount, 1);

      await sub.cancel();
    });

    test('emits [DoctorAppointmentsError] on failure', () async {
      mockUpdateAppointmentStatusUseCase.resultToReturn = Left(Failure('Update failed'));

      final states = <DoctorAppointmentsState>[];
      final sub = cubit.stream.listen(states.add);

      await cubit.updateAppointmentStatus(id: 1, status: 'confirmed');
      await Future.delayed(Duration.zero);

      expect(states.length, 1);
      expect(states[0], isA<DoctorAppointmentsState>());
      expect(states[0], isA<DoctorAppointmentsError>());
      expect((states[0] as DoctorAppointmentsError).message, 'Update failed');

      await sub.cancel();
    });
  });

  group('Real-time push notifications', () {
    test('Pusher event triggers active refresh', () async {
      cubit.fetchToday();
      await Future.delayed(Duration.zero);

      mockPusherService.triggerEvent({'event': 'update'});
      await Future.delayed(Duration.zero);

      expect(mockRefreshTodayAppointmentsUseCase.callCount, 1);
    });

    test('FCM event triggers active refresh', () async {
      cubit.fetchToday();
      await Future.delayed(Duration.zero);

      mockFcmService.triggerEvent({'type': 'appointment_updated'});
      await Future.delayed(Duration.zero);

      expect(mockRefreshTodayAppointmentsUseCase.callCount, 1);
    });
  });
}
