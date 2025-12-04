import 'package:hive_flutter/hive_flutter.dart';

part 'location.g.dart';

@HiveType(typeId: 4)
class Location {
  @HiveField(0)
  int id;

  @HiveField(1)
  double lat;

  @HiveField(2)
  double lng;

  @HiveField(3)
  String name;

  Location({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
  });
}
