import 'dart:convert';

import 'package:blog_app/core/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_response.dart';

class UserDataCache {
  static const String _userKey = 'cached_user_data';
  static const String _cacheTimeKey = 'cached_user_data_time';

  static const Duration cachePeriod = Duration(hours: 1);

  /// Save user data to cache.
  static Future<bool> save(MyUserData user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_userKey, jsonEncode(UserDataCache._toJson(user)));

      await prefs.setInt(_cacheTimeKey, DateTime.now().millisecondsSinceEpoch);

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Get cached user data.
  static Future<CacheResponse<MyUserData>> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userJson = prefs.getString(_userKey);
      final timestamp = prefs.getInt(_cacheTimeKey);

      if (userJson == null || timestamp == null) {
        return const CacheResponse(state: CacheResponseState.invalid);
      }

      final user = UserDataCache._fromJson(jsonDecode(userJson));

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      final age = DateTime.now().difference(cacheTime);

      if (age >= UserDataCache.cachePeriod) {
        await clear();
        return CacheResponse(state: CacheResponseState.expired, cached: user);
      }

      return CacheResponse(state: CacheResponseState.ok, cached: user);
    } catch (e) {
      await UserDataCache.clear();

      return CacheResponse(
        state: CacheResponseState.error,
        error: e.toString(),
      );
    }
  }

  /// Get when the user was cached.
  static Future<DateTime?> getCacheTime() async {
    final prefs = await SharedPreferences.getInstance();

    final timestamp = prefs.getInt(_cacheTimeKey);

    if (timestamp == null) {
      return null;
    }

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Get how old the cached user is.
  static Future<Duration?> getCacheAge() async {
    final cacheTime = await UserDataCache.getCacheTime();

    if (cacheTime == null) {
      return null;
    }

    return DateTime.now().difference(cacheTime);
  }

  /// Check if cached user data is still valid.
  static Future<bool> isValid() async {
    final response = await UserDataCache.get();

    return response.state == CacheResponseState.ok;
  }

  /// Remove cached user data.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
    await prefs.remove(_cacheTimeKey);
  }

  static Map<String, dynamic> _toJson(MyUserData user) {
    return {
      'email': user.email,
      'name': user.name,
      'profileImage': user.profileImage,
      'about': user.about,
      'gender': user.gender,
      'country': user.nationality,
      'interests': user.interests?.map((interest) => interest.value).toList(),
      'birthdate': user.birthdate?.toIso8601String(),
      'createdAt': user.createdAt?.toIso8601String(),
      'lastActive': user.lastActive?.toIso8601String(),
    };
  }

  static MyUserData _fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(Object? value) {
      if (value is! String || value.isEmpty) {
        return null;
      }
      return DateTime.tryParse(value);
    }

    // final interests = (json['interests'] as List<dynamic>?)
    //     ?.map((interest) => InterestItem(interest.toString()))
    //     .toList();

    return MyUserData(
      email: json['email'] as String?,
      name: json['name'] as String?,
      profileImage: json['profileImage'] as String?,
      about: json['about'] as String?,
      // gender: json['gender'] as String?,
      nationality: json['country'] as String?,
      // interests: interests,
      birthdate: parseDate(json['birthdate']),
      createdAt: parseDate(json['createdAt']),
      lastActive: parseDate(json['lastActive']),
    );
  }
}
