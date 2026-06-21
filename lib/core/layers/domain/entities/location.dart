// lib/core/layers/domain/entities/location.dart

class Location {
  int id;
  double lat;
  double lng;
  String name;

  Location({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
  });
}
