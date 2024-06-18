import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = "coffeeCache";

  static CacheManager? _instance;

  static CacheManager getInstance() {
    _instance ??= CacheManager(Config(key,
        stalePeriod: const Duration(hours: 1), maxNrOfCacheObjects: 50));
    return _instance!;
  }
}
