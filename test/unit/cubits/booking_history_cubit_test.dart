import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/repos/booking_history_repo.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/watch_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/refresh_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/presentation/manager/booking_history_cubit/booking_history_cubit.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:flutter_test/flutter_test.dart';

// Pure Dart Mocks to avoid complex dependency conflicts with external testing libraries
class MockCancelAppointmentUseCase implements CancelAppointmentUseCase {
  @override
  late BookingHistoryRepo bookingHistoryRepo;

  Either<Failure, void>? resultToReturn;
  int callCount = 0;
  CancelAppointmentParams? lastParams;

  @override
  Future<Either<Failure, void>> call([CancelAppointmentParams? params]) async {
    callCount++;
    lastParams = params;
    return resultToReturn ?? const Right(null);
  }
}

class MockRescheduleAppointmentUseCase implements RescheduleAppointmentUseCase {
  @override
  late BookingHistoryRepo bookingHistoryRepo;

  Either<Failure, void>? resultToReturn;
  int callCount = 0;
  RescheduleAppointmentParams? lastParams;

  @override
  Future<Either<Failure, void>> call([RescheduleAppointmentParams? params]) async {
    callCount++;
    lastParams = params;
    return resultToReturn ?? const Right(null);
  }
}

class MockWatchBookingHistoryUseCase implements WatchBookingHistoryUseCase {
  @override
  late BookingHistoryRepo bookingHistoryRepo;

  Stream<Either<Failure, List<Booking>>>? streamToReturn;
  int callCount = 0;

  @override
  Stream<Either<Failure, List<Booking>>> call() {
    callCount++;
    return streamToReturn ?? Stream.value(const Right([]));
  }
}

class MockRefreshBookingHistoryUseCase implements RefreshBookingHistoryUseCase {
  @override
  late BookingHistoryRepo bookingHistoryRepo;

  Future<void>? futureToReturn;
  int callCount = 0;

  @override
  Future<void> call() async {
    callCount++;
    return futureToReturn ?? Future.value();
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

// Minimal stub for Booking
class FakeBooking implements Booking {
  @override
  int id = 1;
  @override
  int doctorId = 10;
  @override
  int userId = 100;
  @override
  String date = "2026-05-29";
  @override
  String status = "pending";

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockCancelAppointmentUseCase mockCancelAppointmentUseCase;
  late MockRescheduleAppointmentUseCase mockRescheduleAppointmentUseCase;
  late MockWatchBookingHistoryUseCase mockWatchBookingHistoryUseCase;
  late MockRefreshBookingHistoryUseCase mockRefreshBookingHistoryUseCase;
  late MockPusherService mockPusherService;
  late BookingHistoryCubit bookingHistoryCubit;

  setUp(() {
    mockCancelAppointmentUseCase = MockCancelAppointmentUseCase();
    mockRescheduleAppointmentUseCase = MockRescheduleAppointmentUseCase();
    mockWatchBookingHistoryUseCase = MockWatchBookingHistoryUseCase();
    mockRefreshBookingHistoryUseCase = MockRefreshBookingHistoryUseCase();
    mockPusherService = MockPusherService();

    bookingHistoryCubit = BookingHistoryCubit(
      cancelAppointmentUseCase: mockCancelAppointmentUseCase,
      rescheduleAppointmentUseCase: mockRescheduleAppointmentUseCase,
      watchBookingHistoryUseCase: mockWatchBookingHistoryUseCase,
      refreshBookingHistoryUseCase: mockRefreshBookingHistoryUseCase,
      pusherService: mockPusherService,
    );
  });

  tearDown(() {
    bookingHistoryCubit.close();
  });

  test('initial state should be BookingHistoryInitial', () {
    expect(bookingHistoryCubit.state, isA<BookingHistoryInitial>());
  });

  group('fetchBookingHistory', () {
    test('emits [BookingHistoryLoading, BookingHistoryLoaded] on success stream yield', () async {
      final fakeBookings = [FakeBooking()];
      mockWatchBookingHistoryUseCase.streamToReturn = Stream.value(Right(fakeBookings));

      final states = <BookingHistoryState>[];
      final subscription = bookingHistoryCubit.stream.listen(states.add);

      bookingHistoryCubit.fetchBookingHistory();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<BookingHistoryLoading>());
      expect(states[1], isA<BookingHistoryLoaded>());

      final loadedState = states[1] as BookingHistoryLoaded;
      expect(loadedState.bookings, fakeBookings);
      expect(mockWatchBookingHistoryUseCase.callCount, 1);

      await subscription.cancel();
    });

    test('emits [BookingHistoryLoading, BookingHistoryError] on failure stream yield', () async {
      mockWatchBookingHistoryUseCase.streamToReturn = Stream.value(Left(Failure('Error fetching bookings')));

      final states = <BookingHistoryState>[];
      final subscription = bookingHistoryCubit.stream.listen(states.add);

      bookingHistoryCubit.fetchBookingHistory();
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<BookingHistoryLoading>());
      expect(states[1], isA<BookingHistoryError>());

      final errorState = states[1] as BookingHistoryError;
      expect(errorState.message, 'Error fetching bookings');

      await subscription.cancel();
    });
  });

  group('cancelAppointment', () {
    test('emits [CancelAppointmentLoading, CancelAppointmentSuccess] and refreshes on success', () async {
      mockCancelAppointmentUseCase.resultToReturn = const Right(null);

      final states = <BookingHistoryState>[];
      final subscription = bookingHistoryCubit.stream.listen(states.add);

      await bookingHistoryCubit.cancelAppointment(1, "Sick");
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<CancelAppointmentLoading>());
      expect(states[1], isA<CancelAppointmentSuccess>());
      expect(mockCancelAppointmentUseCase.callCount, 1);
      expect(mockRefreshBookingHistoryUseCase.callCount, 1);

      await subscription.cancel();
    });
  });

  group('rescheduleAppointment', () {
    test('emits [RescheduleAppointmentLoading, RescheduleAppointmentSuccess] and refreshes on success', () async {
      mockRescheduleAppointmentUseCase.resultToReturn = const Right(null);

      final states = <BookingHistoryState>[];
      final subscription = bookingHistoryCubit.stream.listen(states.add);

      await bookingHistoryCubit.rescheduleAppointment(1, "2026-06-01", 100);
      await Future.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], isA<RescheduleAppointmentLoading>());
      expect(states[1], isA<RescheduleAppointmentSuccess>());
      expect(mockRescheduleAppointmentUseCase.callCount, 1);
      expect(mockRefreshBookingHistoryUseCase.callCount, 1);

      await subscription.cancel();
    });
  });

  group('Pusher reactive events', () {
    test('triggers refreshBookingHistoryUseCase on receiving pusher event', () async {
      // Pusher is automatically listened to in constructor.
      // Trigger event:
      mockPusherService.triggerEvent({"type": "update"});

      await Future.delayed(Duration.zero);

      expect(mockRefreshBookingHistoryUseCase.callCount, 1);
    });
  });
}
