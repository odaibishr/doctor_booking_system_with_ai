import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_booking_system_with_ai/core/errors/failure.dart';
import 'package:doctor_booking_system_with_ai/core/services/fcm_service.dart';
import 'package:doctor_booking_system_with_ai/core/services/pusher_service.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/entities/dashboard_stats.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/watch_dashboard_stats_use_case.dart';
import 'package:doctor_booking_system_with_ai/features/doctors_app/domain/usecases/refresh_dashboard_stats_use_case.dart';
import 'package:equatable/equatable.dart';

part 'doctor_dashboard_state.dart';

class DoctorDashboardCubit extends Cubit<DoctorDashboardState> {
  final WatchDashboardStatsUseCase _watchDashboardStatsUseCase;
  final RefreshDashboardStatsUseCase _refreshDashboardStatsUseCase;
  final PusherService _pusherService;
  final FcmService _fcmService;

  StreamSubscription<Either<Failure, DashboardStats>>? _dashboardSub;
  StreamSubscription? _pusherSub;
  StreamSubscription? _fcmSub;
  
  // Track active refresh function to trigger on real-time event updates
  Future<Either<Failure, void>> Function()? _activeRefresh;

  DoctorDashboardCubit({
    required WatchDashboardStatsUseCase watchDashboardStatsUseCase,
    required RefreshDashboardStatsUseCase refreshDashboardStatsUseCase,
    required PusherService pusherService,
    required FcmService fcmService,
  })  : _watchDashboardStatsUseCase = watchDashboardStatsUseCase,
        _refreshDashboardStatsUseCase = refreshDashboardStatsUseCase,
        _pusherService = pusherService,
        _fcmService = fcmService,
        super(DoctorDashboardInitial()) {
    _listenToPusher();
    _listenToFcm();
  }

  void _listenToPusher() {
    _pusherSub?.cancel();
    _pusherSub = _pusherService.eventStream.listen((event) {
      log('DoctorDashboardCubit: REAL-TIME EVENT RECEIVED! $event');
      _activeRefresh?.call();
    });
  }

  void _listenToFcm() {
    _fcmSub?.cancel();
    _fcmSub = _fcmService.eventStream.listen((data) {
      log('DoctorDashboardCubit: REAL-TIME FCM EVENT RECEIVED! $data');
      final type = data['type']?.toString();
      if (type == 'appointment_created' || type == 'appointment_updated') {
        log('DoctorDashboardCubit: Triggering refetch from FCM...');
        _activeRefresh?.call();
      }
    });
  }

  void _safeEmit(DoctorDashboardState state) {
    if (!isClosed) emit(state);
  }

  void fetchDashboard({String filter = 'today'}) {
    _dashboardSub?.cancel();
    _activeRefresh = () => _refreshDashboardStatsUseCase(filter);

    _safeEmit(DoctorDashboardLoading());

    _dashboardSub = _watchDashboardStatsUseCase(filter).listen(
      (result) {
        if (isClosed) return;
        result.fold(
          (failure) => _safeEmit(DoctorDashboardError(failure.errorMessage)),
          (stats) => _safeEmit(DoctorDashboardLoaded(stats)),
        );
      },
      onError: (error) {
        _safeEmit(DoctorDashboardError(error.toString()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _dashboardSub?.cancel();
    await _pusherSub?.cancel();
    await _fcmSub?.cancel();
    _activeRefresh = null;
    return super.close();
  }
}
