import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/notification_model.dart';

class StorageService {
  static const String _keyProfile = 'user_profile';
  static const String _keyNotifications = 'user_notifications';
  static const String _keyPassword = 'user_password';
  static const String _keyIsAuthenticated = 'isAuthenticated';
  static const String _keyEmail = 'user_email';

  Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(profile.toJson());
    await prefs.setString(_keyProfile, jsonStr);
  }

  Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_keyProfile);
    if (jsonStr != null) {
      try {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return UserProfile.fromJson(map);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> saveNotifications(List<NotificationModel> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notifications.map((n) => n.toJson()).toList();
    final jsonStr = jsonEncode(jsonList);
    await prefs.setString(_keyNotifications, jsonStr);
  }

  Future<List<NotificationModel>?> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_keyNotifications);
    if (jsonStr != null) {
      try {
        final list = jsonDecode(jsonStr) as List;
        return list.map((item) => NotificationModel.fromJson(item)).toList();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  Future<String> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword) ?? '123456Abc'; // Default mock password
  }

  Future<void> setAuthenticated(bool val, {String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsAuthenticated, val);
    if (email != null) {
      await prefs.setString(_keyEmail, email);
    } else if (!val) {
      await prefs.remove(_keyEmail);
    }
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsAuthenticated) ?? false;
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? 'student@cogniview.com';
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsAuthenticated);
    await prefs.remove(_keyEmail);
  }
}
