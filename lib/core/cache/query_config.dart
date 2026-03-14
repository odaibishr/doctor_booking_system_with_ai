import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_booking_system_with_ai/core/services/hive_query_storage.dart';

class AppQueryConfig {
  static const Duration defaultRefetchDuration = Duration(minutes: 5);
  static const Duration defaultCacheDuration = Duration(hours: 1);

  static Future<void> init() async {
    await Hive.initFlutter();
    final queryBox = await Hive.openBox('query_cache');

    CachedQuery.instance.configFlutter(
      config: QueryConfigFlutter(
        refetchOnResume: true,
        refetchOnConnection: true,
      ),
      storage: HiveQueryStorage(queryBox),
    );
  }

  static QueryConfig get defaultConfig => QueryConfig(
    refetchDuration: defaultRefetchDuration,
    cacheDuration: defaultCacheDuration,
  );

  static QueryConfig get frequentUpdateConfig => QueryConfig(
    refetchDuration: const Duration(minutes: 2),
    cacheDuration: const Duration(minutes: 30),
  );

  static QueryConfig get rareUpdateConfig => QueryConfig(
    refetchDuration: const Duration(minutes: 15),
    cacheDuration: const Duration(hours: 2),
  );

  static void invalidateAll() {
    CachedQuery.instance.invalidateCache();
  }

  static void invalidateQuery(String key) {
    CachedQuery.instance.invalidateCache(key: key);
  }
}
