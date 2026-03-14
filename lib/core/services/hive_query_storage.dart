import 'dart:async';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveQueryStorage implements StorageInterface {
  final Box<dynamic> _box;

  HiveQueryStorage(this._box);

  @override
  FutureOr<StoredQuery?> get(String key) {
    final map = _box.get(key);
    if (map != null && map is Map) {
      try {
        return StoredQuery(
          key: key,
          data: map['data'],
          createdAt: DateTime.parse(map['createdAt'] as String),
          storageDuration: map['storageDuration'] != null
              ? Duration(milliseconds: map['storageDuration'] as int)
              : null,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  void put(StoredQuery query) {
    dynamic dataToStore = query.data;

    // We only want to cache the success data (Right side of Either)
    if (dataToStore is Either) {
      dataToStore.fold(
        (l) => dataToStore = null, // Don't cache failures
        (r) => dataToStore = r,
      );
    }

    if (dataToStore == null) return;

    _box.put(query.key, {
      'data': dataToStore,
      'createdAt': query.createdAt.toIso8601String(),
      'storageDuration': query.storageDuration?.inMilliseconds,
    });
  }

  @override
  void delete(String key) {
    _box.delete(key);
  }

  @override
  void deleteAll() {
    _box.clear();
  }


  @override
  void close() {}
}
