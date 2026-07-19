class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'Quiz', 'Module', 'Announcement', 'Reminder', 'AR'
  final DateTime date;
  final bool isRead;
  final String userId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.date,
    required this.isRead,
    required this.userId,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? date,
    bool? isRead,
    String? userId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'date': date.toIso8601String(),
      'isRead': isRead,
      'userId': userId,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'Announcement',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      isRead: json['isRead'] ?? false,
      userId: json['userId'] ?? '',
    );
  }
}
