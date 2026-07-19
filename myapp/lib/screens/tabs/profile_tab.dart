import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: AppTheme.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                await authProvider.logout();
                if (context.mounted) {
                  // go router clear history
                  context.go('/welcome');
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profile = authProvider.profile;

    final name = profile != null ? '${profile.firstName} ${profile.lastName}'.trim() : 'Alex Rivera';
    final studentId = profile?.studentId ?? '21-04532';
    final email = profile?.email ?? 'a.rivera@g.batstate-u.edu.ph';
    final department = profile?.department ?? 'Psychology';
    final yearSection = profile != null ? '${profile.yearLevel} - ${profile.section}' : '2nd Year - Section A';
    final avatar = profile?.profilePicture ?? 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&q=80&w=200';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Avatar and Name
            CircleAvatar(
              radius: 54,
              backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.15),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: avatar.startsWith('http')
                    ? NetworkImage(avatar) as ImageProvider
                    : FileImage(File(avatar)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              'BS Psychology',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.badge_outlined, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  studentId,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
                const SizedBox(width: 16),
                Icon(Icons.email_outlined, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  email,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Academic Details Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppTheme.primaryColor.withValues(alpha: 0.12),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACADEMIC DETAILS',
                    style: TextStyle(
                      color: AppTheme.darkGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildAcademicItem(
                    context,
                    Icons.account_balance_rounded,
                    'Department',
                    department,
                  ),
                  const SizedBox(height: 14),
                  _buildAcademicItem(
                    context,
                    Icons.school_rounded,
                    'Year Level',
                    yearSection,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile Options Menu
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkGreen.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildOptionItem(context, Icons.person_outline_rounded, 'Edit Profile', () {
                    context.push('/edit-profile');
                  }),
                  _buildDivider(),
                  _buildOptionItem(context, Icons.lock_outline_rounded, 'Change Password', () {
                    context.push('/change-password');
                  }),
                  _buildDivider(),
                  _buildOptionItem(context, Icons.notifications_none_rounded, 'Notification Settings', () {
                    context.push('/notification-settings');
                  }),
                  _buildDivider(),
                  _buildOptionItem(context, Icons.help_outline_rounded, 'Help & Support', () {
                    context.push('/help-support');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Red Logout Button
            ListTile(
              onTap: () => _showLogoutDialog(context, authProvider),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              tileColor: Colors.red[50]?.withValues(alpha: 0.5),
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
              ),
              title: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAcademicItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.darkGreen, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.darkGreen),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.darkGreen,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[100],
      indent: 16,
      endIndent: 16,
    );
  }
}
