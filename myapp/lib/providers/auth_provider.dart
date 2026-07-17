import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String _userName = '';
  String get userName => _userName;

  AuthProvider() {
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _userName = prefs.getString('userName') ?? '';
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    // Mock login verification
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _userName = email.split('@')[0];
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userName', _userName);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp(String name, String email, String password) async {
    // Mock registration
    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _userName = name;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userName', _userName);

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userName = '';
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
    await prefs.remove('userName');
    
    notifyListeners();
  }
}
