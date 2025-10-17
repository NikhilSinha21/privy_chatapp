import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChatCache {
  static const _cacheKey = "cached_posts";

  static Future<void> save(List<Map<String, dynamic>> posts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(posts));
  }

  static Future<List<Map<String, dynamic>>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cacheKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
