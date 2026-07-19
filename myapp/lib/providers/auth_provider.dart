import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../repositories/profile_repository.dart';
import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  late final ProfileRepository _profileRepository;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String _userName = '';
  String get userName => _userName;

  UserProfile? _profile;
  UserProfile? get profile => _profile;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _profileRepository = ProfileRepository(_storageService);
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    _isAuthenticated = await _storageService.isAuthenticated();
    if (_isAuthenticated) {
      _profile = await _profileRepository.getProfile();
      _userName = '${_profile?.firstName} ${_profile?.lastName}'.trim();
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Verify against saved password or mock check
    final savedPassword = await _storageService.getPassword();
    final profile = await _profileRepository.getProfile();

    if (email.trim() == profile.email && password == savedPassword) {
      _isAuthenticated = true;
      _profile = profile;
      _userName = '${_profile?.firstName} ${_profile?.lastName}'.trim();
      
      await _storageService.setAuthenticated(true, email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    // Secondary mock login verification
    if (email.isNotEmpty && password.length >= 6) {
      _isAuthenticated = true;
      _profile = profile.copyWith(email: email);
      _userName = email.split('@')[0];
      
      await _storageService.setAuthenticated(true, email: email);
      await _profileRepository.updateProfile(_profile!);
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signUp(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      final names = name.split(' ');
      final first = names.isNotEmpty ? names.first : name;
      final last = names.length > 1 ? names.sublist(1).join(' ') : '';
      
      _isAuthenticated = true;
      _profile = UserProfile(
        firstName: first,
        lastName: last,
        studentId: '21-04532',
        email: email,
        yearLevel: '1st Year',
        section: 'Section A',
        profilePicture: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&q=80&w=200',
      );
      _userName = name;

      await _storageService.setAuthenticated(true, email: email);
      await _storageService.savePassword(password);
      await _profileRepository.updateProfile(_profile!);
      
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String studentId,
    required String email,
    required String yearLevel,
    required String section,
    required String profilePicture,
  }) async {
    if (_profile == null) return;
    
    _profile = _profile!.copyWith(
      firstName: firstName,
      lastName: lastName,
      studentId: studentId,
      email: email,
      yearLevel: yearLevel,
      section: section,
      profilePicture: profilePicture,
    );
    
    _userName = '$firstName $lastName'.trim();
    await _profileRepository.updateProfile(_profile!);
    notifyListeners();
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    final isCorrect = await _profileRepository.verifyCurrentPassword(currentPassword);
    if (!isCorrect) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    await _profileRepository.changePassword(newPassword);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> toggleNotificationSetting(String settingType, bool value) async {
    if (_profile == null) return;

    switch (settingType) {
      case 'lesson':
        _profile = _profile!.copyWith(lessonNotifications: value);
        break;
      case 'quiz':
        _profile = _profile!.copyWith(quizNotifications: value);
        break;
      case 'module':
        _profile = _profile!.copyWith(newModuleNotifications: value);
        break;
      case 'ar':
        _profile = _profile!.copyWith(arScanNotifications: value);
        break;
      case 'announcement':
        _profile = _profile!.copyWith(generalAnnouncements: value);
        break;
    }

    await _profileRepository.updateProfile(_profile!);
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _profile = null;
    _userName = '';
    
    await _storageService.clearSession();
    notifyListeners();
  }
}
