// lib/infrastructure/shared_preferences/shared_preferences_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyUserId = 'userId';
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';

  static Future<void> saveSession(
      String userId, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  static Future<Map<String, String>> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_keyUserId) ?? '';
    final email = prefs.getString(_keyEmail) ?? '';
    final password = prefs.getString(_keyPassword) ?? '';
    return {'userId': userId, 'email': email, 'password': password};
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyPassword);
  }

  static Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
  }
}
