import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _debounceTimer;

  NetworkCubit(this._connectivity) : super(NetworkInitial()) {
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void _updateState(List<ConnectivityResult> results) {
    _debounceTimer?.cancel();
    
    final hasConnection = !results.contains(ConnectivityResult.none);

    if (!hasConnection) {
      // Debounce disconnected state to avoid flicker
      _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
        if (!isClosed && state is! NetworkOfflineAcknowledged) {
          emit(NetworkDisconnected());
        }
      });
    } else {
      emit(NetworkConnected());
    }
  }

  Future<void> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateState(results);
  }

  void acknowledgeOffline() {
    emit(NetworkOfflineAcknowledged());
  }

  @override
  Future<void> close() async {
    _debounceTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
