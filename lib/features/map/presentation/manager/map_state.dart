part of 'map_bloc.dart';

enum MapStatus { initial, loading, loaded, error }

class MapState {
  final MapStatus status;
  final List<Doctor> doctors;
  final String? errorMessage;
  final double? userLat;
  final double? userLng;
  final List<LatLng> routePoints;
  final Doctor? focusedDoctor;

  MapState({
    this.status = MapStatus.initial,
    this.doctors = const [],
    this.errorMessage,
    this.userLat,
    this.userLng,
    this.routePoints = const [],
    this.focusedDoctor,
  });

  MapState copyWith({
    MapStatus? status,
    List<Doctor>? doctors,
    String? errorMessage,
    double? userLat,
    double? userLng,
    List<LatLng>? routePoints,
    Doctor? focusedDoctor,
  }) {
    return MapState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage ?? this.errorMessage,
      userLat: userLat ?? this.userLat,
      userLng: userLng ?? this.userLng,
      routePoints: routePoints ?? this.routePoints,
      focusedDoctor: focusedDoctor ?? this.focusedDoctor,
    );
  }
}
