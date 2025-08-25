import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract class untuk local data source
abstract class LocalDataSource {
  Future<void> cacheData(String key, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getCachedData(String key);
  Future<void> clearCache(String key);
  Future<void> clearAllCache();
}

/// Implementation dari LocalDataSource menggunakan SharedPreferences
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _prefs;
  
  const LocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheData(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = json.encode(data);
      await _prefs.setString(key, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getCachedData(String key) async {
    try {
      final jsonString = _prefs.getString(key);
      if (jsonString != null) {
        return json.decode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached data: $e');
    }
  }

  @override
  Future<void> clearCache(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }

  @override
  Future<void> clearAllCache() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw CacheException('Failed to clear all cache: $e');
    }
  }
}

/// Exception untuk cache operations
class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
  
  @override
  String toString() => 'CacheException: $message';
}