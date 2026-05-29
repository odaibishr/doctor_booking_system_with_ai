import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/watch_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/refresh_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:flutter/foundation.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
  final WatchBookingHistoryUseCase watchBookingHistoryUseCase;
  final RefreshBookingHistoryUseCase refreshBookingHistoryUseCase;
  final PusherService pusherService;

  StreamSubscription<Either<Failure, List<Booking>>>? _bookingSub;
  StreamSubscription? _pusherSub;

  BookingHistoryCubit({
    required this.cancelAppointmentUseCase,
    required this.rescheduleAppointmentUseCase,
    required this.watchBookingHistoryUseCase,
    required this.refreshBookingHistoryUseCase,
    required this.pusherService,
  }) : super(const BookingHistoryInitial()) {
    _listenToPusher();
  }

  void fetchBookingHistory() {
    if (isClosed) return;

    emit(BookingHistoryLoading(bookings: state.bookings));

    _bookingSub?.cancel();
    _bookingSub = watchBookingHistoryUseCase().listen(
      (result) {
        if (!isClosed) {
          result.fold(
            (failure) => emit(BookingHistoryError(failure.errorMessage, bookings: state.bookings)),
            (bookings) {
              log('Booking history stream updated: ${bookings.length}');
              emit(BookingHistoryLoaded(bookings));
            },
          );
        }
      },
      onError: (e) {
        if (!isClosed) {
          emit(BookingHistoryError(e.toString(), bookings: state.bookings));
        }
      },
    );
  }

  Future<void> cancelAppointment(int appointmentId, String reason) async {
    if (isClosed) return;
    final currentBookings = state.bookings;
    emit(CancelAppointmentLoading(bookings: currentBookings));

    final result = await cancelAppointmentUseCase(
      CancelAppointmentParams(appointmentId, reason),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(CancelAppointmentError(failure.errorMessage, bookings: currentBookings)),
      (_) {
        emit(CancelAppointmentSuccess(bookings: currentBookings));
        refreshBookingHistoryUseCase();
      },
    );
  }

  Future<void> rescheduleAppointment(
    int appointmentId,
    String date,
    int? scheduleId,
  ) async {
    if (isClosed) return;
    final currentBookings = state.bookings;
    emit(RescheduleAppointmentLoading(bookings: currentBookings));

    final result = await rescheduleAppointmentUseCase(
      RescheduleAppointmentParams(
        appointmentId: appointmentId,
        date: date,
        scheduleId: scheduleId,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(RescheduleAppointmentError(failure.errorMessage, bookings: currentBookings)),
      (_) {
        emit(RescheduleAppointmentSuccess(bookings: currentBookings));
        refreshBookingHistoryUseCase();
      },
    );
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = pusherService.eventStream.listen((event) {
      log('BookingHistoryCubit received Pusher event: $event');
      refreshBookingHistoryUseCase();
    });
  }

  @override
  Future<void> close() async {
    await _bookingSub?.cancel();
    await _pusherSub?.cancel();
    return super.close();
  }
}
