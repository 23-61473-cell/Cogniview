import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profile = authProvider.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.darkGreen),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24.0),
          children: [
            const Text(
              'Customize how you receive learning reminders and announcements from CogniView AR.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSettingCard(
              context,
              title: 'Lesson Notifications',
              subtitle: 'Reminders about current lessons and reading goals.',
              value: profile?.lessonNotifications ?? true,
              onChanged: (val) => authProvider.toggleNotificationSetting('lesson', val),
            ),
            const SizedBox(height: 16),
            
            _buildSettingCard(
              context,
              title: 'Quiz Notifications',
              subtitle: 'Alerts for newly opened quizzes or submission results.',
              value: profile?.quizNotifications ?? true,
              onChanged: (val) => authProvider.toggleNotificationSetting('quiz', val),
            ),
            const SizedBox(height: 16),
            
            _buildSettingCard(
              context,
              title: 'New Module Notifications',
              subtitle: 'Get notified when new study topics are added.',
              value: profile?.newModuleNotifications ?? true,
              onChanged: (val) => authProvider.toggleNotificationSetting('module', val),
            ),
            const SizedBox(height: 16),
            
            _buildSettingCard(
              context,
              title: 'AR Scan Notifications',
              subtitle: 'Updates on 3D brain models and interactive targets.',
              value: profile?.arScanNotifications ?? true,
              onChanged: (val) => authProvider.toggleNotificationSetting('ar', val),
            ),
            const SizedBox(height: 16),
            
            _buildSettingCard(
              context,
              title: 'General Announcements',
              subtitle: 'Messages from administrators or department news.',
              value: profile?.generalAnnouncements ?? true,
              onChanged: (val) => authProvider.toggleNotificationSetting('announcement', val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: AppTheme.primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
