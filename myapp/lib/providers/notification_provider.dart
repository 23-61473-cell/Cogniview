import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../repositories/notification_repository.dart';
import '../services/storage_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repository = NotificationRepository(StorageService());
  
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isBannerDismissed = false;
  bool get isBannerDismissed => _isBannerDismissed;

  NotificationProvider() {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    _notifications = await _repository.getNotifications();
    
    // Sort by date newest first
    _notifications.sort((a, b) => b.date.compareTo(a.date));

    _isLoading = false;
    notifyListeners();
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  NotificationModel? get latestNotification {
    final unread = _notifications.where((n) => !n.isRead).toList();
    if (unread.isEmpty) return null;
    return unread.first;
  }

  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      await _repository.saveNotifications(_notifications);
      notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    await _repository.saveNotifications(_notifications);
    notifyListeners();
  }

  Future<void> deleteNotification(String id) async {
    _notifications.removeWhere((n) => n.id == id);
    await _repository.saveNotifications(_notifications);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    _notifications.clear();
    await _repository.saveNotifications(_notifications);
    notifyListeners();
  }

  void dismissBanner() {
    _isBannerDismissed = true;
    notifyListeners();
  }

  void resetBannerDismissal() {
    _isBannerDismissed = false;
    notifyListeners();
  }
}
