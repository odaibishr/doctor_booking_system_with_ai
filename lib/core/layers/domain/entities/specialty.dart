import 'package:hive_flutter/hive_flutter.dart';

part 'specialty.g.dart';

@HiveType(typeId: 5)
class Specialty {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String icon;

  @HiveField(3)
  bool isActive;

  Specialty({
    required this.id,
    required this.name,
    required this.icon,
    required this.isActive,
  });
}
