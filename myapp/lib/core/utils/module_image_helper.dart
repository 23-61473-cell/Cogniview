import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Resolves a module image asset path from its ID and provides
/// reusable image widgets used on both the dashboard cards and
/// the module detail banner.
///
/// Convention: `assets/images/modules/<moduleId>.jpg`
/// Adding a new module image requires NO code change — simply
/// drop a file named `<moduleId>.jpg` in `assets/images/modules/`.
class ModuleImageHelper {
  ModuleImageHelper._();

  /// Returns the asset path for a given module ID.
  static String assetPath(String moduleId) =>
      'assets/images/modules/$moduleId.jpg';

  /// Builds a rounded image suitable for the module card thumbnail.
  /// Falls back to an icon + gradient if the asset is missing.
  static Widget cardImage({
    required String moduleId,
    required IconData fallbackIcon,
    double height = 110,
    BorderRadius? borderRadius,
  }) {
    final radius = borderRadius ?? BorderRadius.circular(14);
    return ClipRRect(
      borderRadius: radius,
      child: Stack(
        children: [
          Image.asset(
            assetPath(moduleId),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _fallbackCard(height: height, icon: fallbackIcon),
          ),
          // Bottom fade so text below feels connected
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 32,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a full-width banner for the module detail page.
  static Widget bannerImage({
    required String moduleId,
    required IconData fallbackIcon,
    required String moduleTitle,
    double height = 260,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          Image.asset(
            assetPath(moduleId),
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _fallbackBanner(height: height, icon: fallbackIcon),
          ),
          // Dark gradient at bottom for legibility
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),
          // Module title chip
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                moduleTitle.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Private fallbacks ────────────────────────────────────────────────────

  static Widget _fallbackCard({
    required double height,
    required IconData icon,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(icon, color: Colors.white.withValues(alpha: 0.55), size: 36),
    );
  }

  static Widget _fallbackBanner({
    required double height,
    required IconData icon,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      color: AppTheme.primaryColor.withValues(alpha: 0.08),
      child: Icon(icon, color: AppTheme.darkGreen, size: 80),
    );
  }
}
