part of 'booking_history_cubit.dart';

@immutable
sealed class BookingHistoryState {
  final List<Booking> bookings;
  const BookingHistoryState({this.bookings = const []});
}

final class BookingHistoryInitial extends BookingHistoryState {
  const BookingHistoryInitial() : super();
}

final class BookingHistoryLoading extends BookingHistoryState {
  const BookingHistoryLoading({super.bookings});
}

final class BookingHistoryLoaded extends BookingHistoryState {
  const BookingHistoryLoaded(List<Booking> bookings) : super(bookings: bookings);
}

final class BookingHistoryError extends BookingHistoryState {
  final String message;
  const BookingHistoryError(this.message, {super.bookings});
}

final class CancelAppointmentLoading extends BookingHistoryState {
  const CancelAppointmentLoading({super.bookings});
}

final class CancelAppointmentSuccess extends BookingHistoryState {
  const CancelAppointmentSuccess({super.bookings});
}

final class CancelAppointmentError extends BookingHistoryState {
  final String message;
  const CancelAppointmentError(this.message, {super.bookings});
}

final class RescheduleAppointmentLoading extends BookingHistoryState {
  const RescheduleAppointmentLoading({super.bookings});
}

final class RescheduleAppointmentSuccess extends BookingHistoryState {
  const RescheduleAppointmentSuccess({super.bookings});
}

final class RescheduleAppointmentError extends BookingHistoryState {
  final String message;
  const RescheduleAppointmentError(this.message, {super.bookings});
}
