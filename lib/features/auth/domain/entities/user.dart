// lib/features/auth/domain/entities/user.dart

import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });
}
