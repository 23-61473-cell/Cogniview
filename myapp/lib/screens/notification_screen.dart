import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../models/notification_model.dart';
import '../providers/notification_provider.dart';
import '../providers/dashboard_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'quiz':
        return Icons.stars_rounded;
      case 'module':
        return Icons.menu_book_rounded;
      case 'ar':
        return Icons.camera_enhance_rounded;
      case 'reminder':
        return Icons.assignment_turned_in_rounded;
      case 'announcement':
      default:
        return Icons.campaign_rounded;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'quiz':
        return Colors.orangeAccent;
      case 'module':
        return AppTheme.primaryColor;
      case 'ar':
        return AppTheme.darkGreen;
      case 'reminder':
        return Colors.blueAccent;
      case 'announcement':
      default:
        return Colors.redAccent;
    }
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }

  void _handleNotificationTap(BuildContext context, NotificationModel notification) {
    final notifProvider = Provider.of<NotificationProvider>(context, listen: false);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);

    // Mark as read first
    notifProvider.markAsRead(notification.id);

    // Navigate to related content
    switch (notification.type.toLowerCase()) {
      case 'module':
        // Navigate to module detail
        dashProvider.selectModule('visual_structures'); // default/first module
        context.push('/module-detail');
        break;
      case 'quiz':
        // Switch to Quiz Tab in Dashboard
        dashProvider.setTabIndex(3);
        context.go('/');
        break;
      case 'ar':
        // Switch to AR tab
        dashProvider.setTabIndex(2);
        context.go('/');
        break;
      case 'reminder':
      case 'announcement':
      default:
        // Switch to Home tab
        dashProvider.setTabIndex(0);
        context.go('/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifProvider = Provider.of<NotificationProvider>(context);
    final notifications = notifProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.darkGreen),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (notifications.isNotEmpty) ...[
            TextButton(
              onPressed: () => notifProvider.markAllAsRead(),
              child: const Text(
                'Mark All Read',
                style: TextStyle(color: AppTheme.darkGreen, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
              onPressed: () => notifProvider.deleteAll(),
              tooltip: 'Delete All',
            ),
          ],
        ],
      ),
      body: SafeArea(
        child: notifProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_none_rounded, size: 72, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'All caught up!',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'No notifications to show.',
                          style: TextStyle(color: Colors.grey[400], fontSize: 13),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final item = notifications[index];
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
                        ),
                        onDismissed: (direction) {
                          notifProvider.deleteNotification(item.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Notification deleted'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: _buildNotificationCard(context, item, notifProvider),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificationModel item,
    NotificationProvider provider,
  ) {
    final iconColor = _getColorForType(item.type);
    final iconData = _getIconForType(item.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.white : AppTheme.primaryColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: item.isRead
              ? Colors.grey[100]!
              : AppTheme.primaryColor.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.12),
          child: Icon(iconData, color: iconColor),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: AppTheme.darkGreen,
                  fontWeight: item.isRead ? FontWeight.w600 : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            if (!item.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              item.message,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatTimeAgo(item.date),
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 11,
              ),
            ),
          ],
        ),
        onTap: () => _handleNotificationTap(context, item),
        onLongPress: () {
          if (!item.isRead) {
            provider.markAsRead(item.id);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Marked as read'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }
}
