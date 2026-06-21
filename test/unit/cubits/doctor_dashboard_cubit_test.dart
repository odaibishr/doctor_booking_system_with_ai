import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/earnings_data.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/repos/doctor_dashboard_repo.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/presentation/manager/dashboard/doctor_dashboard_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks
class MockWatchDashboardStatsUseCase implements WatchDashboardStatsUseCase {
  @override
  late DoctorDashboardRepo doctorDashboardRepo;

  Stream<Either<Failure, DashboardStats>>? streamToReturn;
  int callCount = 0;
  String? lastFilter;

  @override
  Stream<Either<Failure, DashboardStats>> call(String filter) {
    callCount++;
    lastFilter = filter;
    return streamToReturn ?? Stream.value(Right(makeFakeDashboardStats()));
  }
}

class MockRefreshDashboardStatsUseCase implements RefreshDashboardStatsUseCase {
  @override
  late DoctorDashboardRepo doctorDashboardRepo;

  Future<Either<Failure, void>>? futureToReturn;
  int callCount = 0;
  String? lastFilter;

  @override
  Future<Either<Failure, void>> call(String filter) async {
    callCount++;
    lastFilter = filter;
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

DashboardStats makeFakeDashboardStats() {
  return DashboardStats(
    todayAppointments: 5,
    upcomingAppointments: 10,
    completedAppointments: 15,
    cancelledAppointments: 2,
    totalPatients: 30,
    todayPatients: 4,
    earnings: EarningsData(today: 100, week: 500, month: 2000, all: 5000, filtered: 100),
    reviewsAvg: 4,
    reviewsCount: 12,
    workingHours: const [],
    daysOff: const [],
  );
}

void main() {
  late MockWatchDashboardStatsUseCase mockWatchDashboardStatsUseCase;
  late MockRefreshDashboardStatsUseCase mockRefreshDashboardStatsUseCase;
  late MockPusherService mockPusherService;
  late MockFcmService mockFcmService;
  late DoctorDashboardCubit cubit;

  setUp(() {
    mockWatchDashboardStatsUseCase = MockWatchDashboardStatsUseCase();
    mockRefreshDashboardStatsUseCase = MockRefreshDashboardStatsUseCase();
    mockPusherService = MockPusherService();
    mockFcmService = MockFcmService();

    cubit = DoctorDashboardCubit(
      watchDashboardStatsUseCase: mockWatchDashboardStatsUseCase,
      refreshDashboardStatsUseCase: mockRefreshDashboardStatsUseCase,
      pusherService: mockPusherService,
      fcmService: mockFcmService,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state is DoctorDashboardInitial', () {
    expect(cubit.state, isA<DoctorDashboardInitial>());
  });

  group('fetchDashboard', () {
    test('emits [Loading, Loaded] on success stream yield', () async {
      final stats = makeFakeDashboardStats();
      mockWatchDashboardStatsUseCase.streamToReturn = Stream.value(Right(stats));

      final states = <DoctorDashboardState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchDashboard(filter: 'week');
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorDashboardLoading>());
      expect(states[1], isA<DoctorDashboardLoaded>());
      expect((states[1] as DoctorDashboardLoaded).stats, stats);
      expect(mockWatchDashboardStatsUseCase.lastFilter, 'week');

      await sub.cancel();
    });

    test('emits [Loading, Error] on failure stream yield', () async {
      mockWatchDashboardStatsUseCase.streamToReturn = Stream.value(Left(Failure('Dashboard error')));

      final states = <DoctorDashboardState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.fetchDashboard(filter: 'month');
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<DoctorDashboardLoading>());
      expect(states[1], isA<DoctorDashboardError>());
      expect((states[1] as DoctorDashboardError).message, 'Dashboard error');
      expect(mockWatchDashboardStatsUseCase.lastFilter, 'month');

      await sub.cancel();
    });
  });

  group('Real-time push notifications', () {
    test('Pusher event triggers active refresh', () async {
      cubit.fetchDashboard(filter: 'today');
      await Future.delayed(Duration.zero);

      mockPusherService.triggerEvent({'event': 'update'});
      await Future.delayed(Duration.zero);

      expect(mockRefreshDashboardStatsUseCase.callCount, 1);
      expect(mockRefreshDashboardStatsUseCase.lastFilter, 'today');
    });

    test('FCM event triggers active refresh', () async {
      cubit.fetchDashboard(filter: 'month');
      await Future.delayed(Duration.zero);

      mockFcmService.triggerEvent({'type': 'appointment_created'});
      await Future.delayed(Duration.zero);

      expect(mockRefreshDashboardStatsUseCase.callCount, 1);
      expect(mockRefreshDashboardStatsUseCase.lastFilter, 'month');
    });
  });
}
