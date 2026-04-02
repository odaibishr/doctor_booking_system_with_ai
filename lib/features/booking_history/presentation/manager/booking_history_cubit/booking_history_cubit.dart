import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:flutter/foundation.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
  final PusherService pusherService;

  Query<Either<Failure, List<Booking>>>? _bookingQuery;
  StreamSubscription<QueryState<Either<Failure, List<Booking>>>>? _querySub;
  StreamSubscription? _pusherSub;

  BookingHistoryCubit(
    this.cancelAppointmentUseCase,
    this.rescheduleAppointmentUseCase,
    this.pusherService,
  ) : super(const BookingHistoryInitial()) {
    _listenToPusher();
  }

  void fetchBookingHistory() {
    if (isClosed) return;

    _bookingQuery = bookingHistoryQuery();

    final currentData = _bookingQuery!.state.data;
    if (currentData != null) {
      currentData.fold((_) {}, (bookings) {
        if (!isClosed) emit(BookingHistoryLoaded(bookings));
      });
    } else {
      if (!isClosed) emit(BookingHistoryLoading(bookings: state.bookings));
    }

    _querySub?.cancel();
    _querySub = _bookingQuery!.stream.listen((queryState) {
      if (isClosed) return;

      if (queryState.status == QueryStatus.loading && queryState.data == null) {
        emit(BookingHistoryLoading(bookings: state.bookings));
        return;
      }

      if (queryState.data != null) {
        queryState.data!.fold(
          (failure) => emit(BookingHistoryError(failure.errorMessage,
              bookings: state.bookings)),
          (bookings) {
            log('Booking history stream updated: ${bookings.length}');
            emit(BookingHistoryLoaded(bookings));
          },
        );
      } else if (queryState.status == QueryStatus.error) {
        emit(BookingHistoryError('فشل في جلب البيانات',
            bookings: state.bookings));
      }
    });
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
      (failure) => emit(CancelAppointmentError(failure.errorMessage,
          bookings: currentBookings)),
      (_) {
        emit(CancelAppointmentSuccess(bookings: currentBookings));
        invalidateBookingHistoryCache();
        _bookingQuery?.refetch();
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
      (failure) => emit(RescheduleAppointmentError(failure.errorMessage,
          bookings: currentBookings)),
      (_) {
        emit(RescheduleAppointmentSuccess(bookings: currentBookings));
        invalidateBookingHistoryCache();
        _bookingQuery?.refetch();
      },
    );
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = pusherService.eventStream.listen((event) {
      log('BookingHistoryCubit received Pusher event: $event');
      // Invalidate cache and REFETCH to trigger a refresh
      invalidateBookingHistoryCache();
      _bookingQuery?.refetch();
    });
  }

  @override
  Future<void> close() async {
    await _querySub?.cancel();
    await _pusherSub?.cancel();
    _bookingQuery = null;
    return super.close();
  }
}
