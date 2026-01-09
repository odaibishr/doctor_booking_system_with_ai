import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/domain/repos/waitlist_repo.dart';
import 'package:doctor_booking_system_with_ai/features/waitlist/presentation/cubit/waitlist_state.dart';

class WaitlistCubit extends Cubit<WaitlistState> {
  final WaitlistRepo _repo;

  WaitlistCubit(this._repo) : super(WaitlistInitial());

  Future<void> joinWaitlist({
    required int doctorId,
    String? preferredDate,
    int? preferredScheduleId,
  }) async {
    emit(WaitlistJoining());

    final result = await _repo.joinWaitlist(
      doctorId: doctorId,
      preferredDate: preferredDate,
      preferredScheduleId: preferredScheduleId,
    );

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (entry) => emit(WaitlistJoined(entry: entry, position: entry.position)),
    );
  }

  Future<void> leaveWaitlist(int waitlistId) async {
    emit(WaitlistLeaving());

    final result = await _repo.leaveWaitlist(waitlistId);

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (_) => emit(WaitlistLeft()),
    );
  }

  Future<void> loadMyWaitlists() async {
    emit(WaitlistLoading());

    final result = await _repo.getMyWaitlists();

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (waitlists) => emit(WaitlistLoaded(waitlists: waitlists)),
    );
  }

  Future<void> getPosition(int doctorId) async {
    emit(WaitlistLoading());

    final result = await _repo.getPosition(doctorId);

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (positionInfo) =>
          emit(WaitlistPositionLoaded(positionInfo: positionInfo)),
    );
  }

  Future<void> acceptSlot({
    required int waitlistId,
    required String date,
    required int doctorScheduleId,
    required String paymentMode,
  }) async {
    emit(WaitlistAccepting());

    final result = await _repo.acceptSlot(
      waitlistId: waitlistId,
      date: date,
      doctorScheduleId: doctorScheduleId,
      paymentMode: paymentMode,
    );

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (appointment) => emit(WaitlistSlotAccepted(appointment: appointment)),
    );
  }

  Future<void> declineSlot(int waitlistId) async {
    emit(WaitlistDeclining());

    final result = await _repo.declineSlot(waitlistId);

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (_) => emit(WaitlistSlotDeclined()),
    );
  }

  Future<void> checkDoctorAvailability(int doctorId) async {
    emit(WaitlistLoading());

    final result = await _repo.checkDoctorAvailability(doctorId);

    result.fold(
      (failure) => emit(WaitlistError(message: failure.errorMessage)),
      (availabilityInfo) =>
          emit(DoctorAvailabilityLoaded(availabilityInfo: availabilityInfo)),
    );
  }

  void notifySlotAvailable(Map<String, dynamic> notificationData) {
    // This will be called from FCM notification handler
    // Parse notification data and emit slot available state
  }
}
