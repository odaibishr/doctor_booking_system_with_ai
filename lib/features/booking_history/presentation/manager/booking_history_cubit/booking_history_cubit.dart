import 'package:bloc/bloc.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/entities/booking.dart';
import 'package:doctor_booking_system_with_ai/features/booking_history/domain/usecases/get_booking_history_use_case.dart';
import 'package:flutter/foundation.dart';

part 'booking_history_state.dart';

class BookingHistoryCubit extends Cubit<BookingHistoryState> {
  final GetBookingHistoryUseCase getBookingHistoryUseCase;

  BookingHistoryCubit(this.getBookingHistoryUseCase)
      : super(BookingHistoryInitial());

  Future<void> fetchBookingHistory() async {
    emit(BookingHistoryLoading());
    try {
      final result = await getBookingHistoryUseCase();

      result.fold(
        (failure) => emit(BookingHistoryError(failure.errorMessage)),
        (bookings) => emit(BookingHistoryLoaded(bookings)),
      );
    } catch (error) {
      emit(BookingHistoryError(error.toString()));
    }
  }
}
