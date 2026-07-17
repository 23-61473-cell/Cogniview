import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../providers/dashboard_provider.dart';
import 'tabs/home_tab.dart';
import 'tabs/modules_tab.dart';
import 'tabs/placeholder_tab.dart';
import 'tabs/quiz_tab.dart';
import 'tabs/profile_tab.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    // List of screens corresponding to navigation index
    final List<Widget> tabs = [
      const HomeTab(),
      const ModulesTab(),
      const PlaceholderTab(
        title: 'AR Camera & Brain Model',
        description: 'Interactive Augmented Reality brain mapping and real-time anatomical scanner.',
        icon: Icons.camera_enhance_rounded,
      ),
      const QuizTab(),
      const ProfileTab(),
    ];

    // Titles matching current active index
    final List<String> titles = [
      'Dashboard',
      'Modules',
      'AR Scanning',
      'Cognitive Quiz',
      'Profile',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Safe checking for assets loading, we fall back to icon if asset is not present or throws
            Image.asset(
              'assets/logo (2).png',
              height: 36,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.psychology_rounded,
                  color: AppTheme.darkGreen,
                  size: 32,
                );
              },
            ),
            const SizedBox(width: 10),
            Text(
              titles[provider.currentTabIndex],
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: AppTheme.darkGreen,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.darkGreen),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.15),
            child: const Icon(
              Icons.person_rounded,
              color: AppTheme.darkGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: tabs[provider.currentTabIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkGreen.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            padding: EdgeInsets.zero,
            height: 75,
            color: Colors.white,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, provider, 0, Icons.home_rounded, 'Home'),
                _buildNavItem(context, provider, 1, Icons.menu_book_rounded, 'Modules'),
                _buildCenterNavItem(context, provider, 2),
                _buildNavItem(context, provider, 3, Icons.stars_rounded, 'Quiz'),
                _buildNavItem(context, provider, 4, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    DashboardProvider provider,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = provider.currentTabIndex == index;
    return InkWell(
      onTap: () => provider.setTabIndex(index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.darkGreen : Colors.grey[400],
              size: 26,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.darkGreen : Colors.grey[500],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterNavItem(
    BuildContext context,
    DashboardProvider provider,
    int index,
  ) {
    return GestureDetector(
      onTap: () => provider.setTabIndex(index),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppTheme.primaryColor,
              AppTheme.darkGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkGreen.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: const Icon(
          Icons.camera_enhance_rounded,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
