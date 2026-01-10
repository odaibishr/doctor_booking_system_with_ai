part of 'booking_history_cubit.dart';

@immutable
sealed class BookingHistoryState {}

final class BookingHistoryInitial extends BookingHistoryState {}

final class BookingHistoryLoading extends BookingHistoryState {}

final class BookingHistoryLoaded extends BookingHistoryState {
  final List<Booking> bookings;
  BookingHistoryLoaded(this.bookings);
}

final class BookingHistoryError extends BookingHistoryState {
  final String message;
  BookingHistoryError(this.message);
}

final class CancelAppointmentLoading extends BookingHistoryState {}

final class CancelAppointmentSuccess extends BookingHistoryState {}

final class CancelAppointmentError extends BookingHistoryState {
  final String message;
  CancelAppointmentError(this.message);
}
