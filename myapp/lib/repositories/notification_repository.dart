import '../models/notification_model.dart';
import '../services/storage_service.dart';

class NotificationRepository {
  final StorageService _storageService;

  NotificationRepository(this._storageService);

  Future<List<NotificationModel>> getNotifications() async {
    final list = await _storageService.getNotifications();
    if (list != null) {
      return list;
    }

    // Default mock notifications ordered by newest first
    final List<NotificationModel> defaultNotifications = [
      NotificationModel(
        id: '1',
        title: 'New Module Available',
        message: 'Memory and Attention Module has been added.',
        type: 'Module',
        date: DateTime.now().subtract(const Duration(minutes: 5)),
        isRead: false,
        userId: 'current_user',
      ),
      NotificationModel(
        id: '2',
        title: 'Quiz Notice',
        message: 'Memory Quiz is now open.',
        type: 'Quiz',
        date: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: false,
        userId: 'current_user',
      ),
      NotificationModel(
        id: '3',
        title: 'Congratulations!',
        message: 'You completed the Attention lesson.',
        type: 'Reminder',
        date: DateTime.now().subtract(const Duration(hours: 4)),
        isRead: true,
        userId: 'current_user',
      ),
      NotificationModel(
        id: '4',
        title: 'AR Scanning',
        message: 'New Brain Model Added.',
        type: 'AR',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        userId: 'current_user',
      ),
      NotificationModel(
        id: '5',
        title: 'Quiz Completed',
        message: 'Your quiz score has been recorded.',
        type: 'Quiz',
        date: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
        userId: 'current_user',
      ),
    ];

    await _storageService.saveNotifications(defaultNotifications);
    return defaultNotifications;
  }

  Future<void> saveNotifications(List<NotificationModel> list) async {
    await _storageService.saveNotifications(list);
  }
}
