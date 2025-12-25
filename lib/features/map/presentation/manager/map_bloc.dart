import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:doctor_booking_system_with_ai/core/layers/domain/entities/doctor.dart';
import 'package:doctor_booking_system_with_ai/core/layers/domain/usecases/get_doctors_use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:dio/dio.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final Dio dio = Dio();

  MapBloc({required this.getDoctorsUseCase}) : super(MapState()) {
    on<FetchDoctorsForMap>(_onFetchDoctors);
    on<UpdateUserLocation>(_onUpdateUserLocation);
    on<GetDirectionsToDoctor>(_onGetDirections);
  }

  Future<void> _onGetDirections(
    GetDirectionsToDoctor event,
    Emitter<MapState> emit,
  ) async {
    try {
      // 1. Initial State
      emit(state.copyWith(focusedDoctor: event.doctor, routePoints: []));

      // 2. Location Check (Sequential & Robust)
      if (state.userLat == null || state.userLng == null) {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          log("Location services disabled");
          return;
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) return;
        }

        if (permission == LocationPermission.deniedForever) return;

        final position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.low,
          ),
        ).timeout(const Duration(seconds: 7), onTimeout: () => throw "Timeout");

        emit(
          state.copyWith(
            userLat: position.latitude,
            userLng: position.longitude,
          ),
        );
      }

      final double uLat = state.userLat!;
      final double uLng = state.userLng!;
      final double dLat = event.doctor.location.lat;
      final double dLng = event.doctor.location.lng;

      // 3. API Call
      final url =
          'https://router.project-osrm.org/route/v1/driving/$uLng,$uLat;$dLng,$dLat?overview=full&geometries=polyline';
      final response = await dio.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          final String poly = data['routes'][0]['geometry'];
          final List<LatLng> points = _decodePolyline(poly);
          if (points.isNotEmpty) {
            emit(state.copyWith(routePoints: points));
          }
        }
      }
    } catch (e) {
      log("MapBloc Directions Error: $e");
    }
  }

  List<LatLng> _decodePolyline(String str) {
    List<LatLng> points = [];
    int index = 0, len = str.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = str.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = str.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> _onFetchDoctors(
    FetchDoctorsForMap event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      // Get location if not already available
      if (state.userLat == null || state.userLng == null) {
        final position = await _determinePosition();
        if (position != null) {
          emit(
            state.copyWith(
              userLat: position.latitude,
              userLng: position.longitude,
            ),
          );
        }
      }

      final result = await getDoctorsUseCase();

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: MapStatus.error,
            errorMessage: failure.errorMessage,
          ),
        ),
        (doctors) {
          final double baseLat = state.userLat ?? 15.35;
          final double baseLng = state.userLng ?? 44.20;

          final Map<String, int> overlapTracker = {};
          final List<Doctor> processedDoctors = doctors.map((doctor) {
            double lat = doctor.location.lat;
            double lng = doctor.location.lng;

            // 1. Handle default/missing location
            if (lat == 0.0 && lng == 0.0) {
              lat = baseLat;
              lng = baseLng;
            }

            // 2. Dispersal Logic: Add slight offset if coordinates are identical
            final String coordKey =
                "${lat.toStringAsFixed(6)}|${lng.toStringAsFixed(6)}";
            final int overlapIndex = overlapTracker[coordKey] ?? 0;
            overlapTracker[coordKey] = overlapIndex + 1;

            if (overlapIndex > 0) {
              // Reduced offset for closer proximity (approx 10-15 meters per step)
              lat +=
                  (0.00012 *
                  (overlapIndex % 2 == 0 ? 1 : -1) *
                  ((overlapIndex + 1) ~/ 2));
              lng +=
                  (0.00012 *
                  (overlapIndex % 3 == 0 ? 1 : -1) *
                  (overlapIndex ~/ 3));
            }

            // Update doctor object (local copy for map)
            doctor.location.lat = lat;
            doctor.location.lng = lng;
            return doctor;
          }).toList();

          if (state.userLat != null && state.userLng != null) {
            processedDoctors.sort((a, b) {
              final dA = Geolocator.distanceBetween(
                state.userLat!,
                state.userLng!,
                a.location.lat,
                a.location.lng,
              );
              final dB = Geolocator.distanceBetween(
                state.userLat!,
                state.userLng!,
                b.location.lat,
                b.location.lng,
              );
              return dA.compareTo(dB);
            });
          }

          emit(
            state.copyWith(status: MapStatus.loaded, doctors: processedDoctors),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MapStatus.error,
          errorMessage: "حدث خطأ أثناء تحديد الموقع",
        ),
      );
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(userLat: event.lat, userLng: event.lng));

    // If doctors are already loaded, we might want to re-sort them
    if (state.status == MapStatus.loaded) {
      final List<Doctor> sortedDoctors = List.from(state.doctors);
      sortedDoctors.sort((a, b) {
        final double distanceA = Geolocator.distanceBetween(
          event.lat,
          event.lng,
          a.location.lat,
          a.location.lng,
        );
        final double distanceB = Geolocator.distanceBetween(
          event.lat,
          event.lng,
          b.location.lat,
          b.location.lng,
        );
        return distanceA.compareTo(distanceB);
      });
      emit(state.copyWith(doctors: sortedDoctors));
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    add(UpdateUserLocation(position.latitude, position.longitude));
  }
}
