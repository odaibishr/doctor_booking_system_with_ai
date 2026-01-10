import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/cancel_appointment_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/get_booking_history_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/reschedule_appointment_use_case.dart';
import 'package:flutter/foundation.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final GetBookingHistoryUseCase getBookingHistoryUseCase;
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
  int _requestId = 0;

  BookingHistoryCubit(
    this.getBookingHistoryUseCase,
    this.cancelAppointmentUseCase,
    this.rescheduleAppointmentUseCase,
  ) : super(BookingHistoryInitial());

  Future<void> fetchBookingHistory() async {
    final requestId = ++_requestId;
    if (isClosed) return;

    emit(BookingHistoryLoading());
    try {
      final result = await getBookingHistoryUseCase();
      if (isClosed || requestId != _requestId) return;

      result.fold(
        (failure) {
          if (isClosed || requestId != _requestId) return;
          emit(BookingHistoryError(failure.errorMessage));
        },
        (bookings) {
          if (isClosed || requestId != _requestId) return;
          emit(BookingHistoryLoaded(bookings));
        },
      );
    } catch (error) {
      if (isClosed || requestId != _requestId) return;
      emit(BookingHistoryError(error.toString()));
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
        fetchBookingHistory();
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
        fetchBookingHistory();
      },
    );
  }

  @override
  Future<void> close() {
    _requestId++;
    return super.close();
  }
}
