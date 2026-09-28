import 'dart:convert';

import 'package:blog_app/core/storage/cache_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserCache {
  static const String _userKey = 'cached_user';
  static const String _cacheTimeKey = 'cached_user_time';

  /// How long the cached user remains valid.
  static const Duration cachePeriod = Duration(hours: 1);

  /// Save the user and the current cache time.
  static Future<CacheResponse<void>> save(MyUser user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_userKey, jsonEncode(user.toJson()));

      await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);
      return CacheResponse(state: CacheResponseState.ok);
    } catch (e) {
      return CacheResponse(
        state: CacheResponseState.error,
        error: e.toString(),
      );
    }
  }

  /// Get the cached user and its cache state.
  static Future<CacheResponse<MyUser>> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userJson = prefs.getString(_userKey);
      final timestamp = prefs.getInt(_cacheTimeKey);

      // No cached user or no cache time.
      if (userJson == null || timestamp == null) {
        return const CacheResponse(state: CacheResponseState.invalid);
      }

      final user = MyUser.fromJson(jsonDecode(userJson));

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      final age = DateTime.now().difference(cacheTime);

      // Cache is expired, but return the old user too.
      if (age >= UserCache.cachePeriod) {
        await UserCache.clear();
        return CacheResponse(state: CacheResponseState.expired, cached: user);
      }

      return CacheResponse(state: CacheResponseState.ok, cached: user);
    } catch (e) {
      await clear();

      return CacheResponse(
        state: CacheResponseState.error,
        error: e.toString(),
      );
    }
  }

  /// Get the time when the user was cached.
  static Future<DateTime?> getCacheTime() async {
    final prefs = await SharedPreferences.getInstance();

    final timestamp = prefs.getInt(_cacheTimeKey);

    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Get how old the cache is.
  static Future<Duration?> getCacheAge() async {
    final cacheTime = await UserCache.getCacheTime();

    if (cacheTime == null) {
      return null;
    }

    return DateTime.now().difference(cacheTime);
  }

  /// Check whether the cache is still valid.
  static Future<bool> isValid() async {
    final response = await UserCache.get();

    return response.state == CacheResponseState.ok;
  }

  /// Delete the cached user and cache time.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
    await prefs.remove(_cacheTimeKey);
  }
}
