part of 'map_bloc.dart';

abstract class MapEvent {}

class FetchDoctorsForMap extends MapEvent {}

class UpdateUserLocation extends MapEvent {
  final double lat;
  final double lng;
  UpdateUserLocation(this.lat, this.lng);
}

class GetDirectionsToDoctor extends MapEvent {
  final Doctor doctor;
  GetDirectionsToDoctor(this.doctor);
}
