import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/cache/cache_exports.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:flutter/foundation.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
  Query<Either<Failure, List<Booking>>>? _bookingQuery;

  BookingHistoryCubit(
    this.cancelAppointmentUseCase,
    this.rescheduleAppointmentUseCase,
  ) : super(BookingHistoryInitial());

  Future<void> fetchBookingHistory({bool forceRefresh = false}) async {
    _bookingQuery = bookingHistoryQuery();

    final cachedData = _bookingQuery!.state.data;
    if (cachedData != null && !forceRefresh) {
      cachedData.fold(
        (failure) => emit(BookingHistoryError(failure.errorMessage)),
        (bookings) {
          log('Loaded booking history from cache: ${bookings.length}');
          emit(BookingHistoryLoaded(bookings));
        },
      );

      _refetchIfStale();
      return;
    }

    emit(BookingHistoryLoading());

    final queryState = await _bookingQuery!.result;
    final result = queryState.data;
    if (result == null) {
      emit(BookingHistoryError('Failed to fetch booking history'));
      return;
    }
    result.fold((failure) => emit(BookingHistoryError(failure.errorMessage)), (
      bookings,
    ) {
      log('Fetched booking history from API: ${bookings.length}');
      emit(BookingHistoryLoaded(bookings));
    });
  }

  Future<void> _refetchIfStale() async {
    if (_bookingQuery == null) return;

    final state = _bookingQuery!.state;
    final isStale =
        state.status == QueryStatus.success &&
        DateTime.now().difference(state.timeCreated) >
            AppQueryConfig.defaultRefetchDuration;

    if (isStale) {
      log('Background refetch: booking history data is stale');
      await _bookingQuery!.refetch();
      final result = _bookingQuery!.state.data;
      if (result != null && !isClosed) {
        result.fold((_) {}, (bookings) => emit(BookingHistoryLoaded(bookings)));
      }
    }
  }

  Future<void> cancelAppointment(int appointmentId, String reason) async {
    emit(CancelAppointmentLoading());

    final result = await cancelAppointmentUseCase(
      CancelAppointmentParams(appointmentId, reason),
    );

    result.fold(
      (failure) => emit(CancelAppointmentError(failure.errorMessage)),
      (_) {
        emit(CancelAppointmentSuccess());
        invalidateBookingHistoryCache();
        fetchBookingHistory(forceRefresh: true);
      },
    );
  }

  Future<void> rescheduleAppointment(
    int appointmentId,
    String date,
    int? scheduleId,
  ) async {
    emit(RescheduleAppointmentLoading());

    final result = await rescheduleAppointmentUseCase(
      RescheduleAppointmentParams(
        appointmentId: appointmentId,
        date: date,
        scheduleId: scheduleId,
      ),
    );

    result.fold(
      (failure) => emit(RescheduleAppointmentError(failure.errorMessage)),
      (_) {
        emit(RescheduleAppointmentSuccess());
        invalidateBookingHistoryCache();
        fetchBookingHistory(forceRefresh: true);
      },
    );
  }

  void invalidateCache() {
    invalidateBookingHistoryCache();
  }

  @override
  Future<void> close() {
    _bookingQuery = null;
    return super.close();
  }
}
