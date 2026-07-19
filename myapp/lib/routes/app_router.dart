import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/module_detail_screen.dart';
import '../screens/module_details_screen.dart';
import '../screens/chapter_content_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/change_password_screen.dart';
import '../screens/notification_settings_screen.dart';
import '../screens/help_support_screen.dart';
import '../screens/notification_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      // Legacy route kept for backward compatibility with existing push('/module-detail') calls.
      GoRoute(
        path: '/module-detail',
        builder: (context, state) => const ModuleDetailScreen(),
      ),
      // New route: Module Details screen with local chapter data.
      GoRoute(
        path: '/module-details/:moduleId',
        builder: (context, state) {
          final moduleId = state.pathParameters['moduleId'] ?? '';
          return ModuleDetailsScreen(moduleId: moduleId);
        },
      ),
      // Chapter content route — receives extra map {moduleId, chapterNumber}.
      GoRoute(
        path: '/chapter-content',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ChapterContentScreen(
            moduleId: extra['moduleId'] as String? ?? '',
            chapterNumber: extra['chapterNumber'] as int? ?? 1,
          );
        },
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/notification-settings',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
  );
}
