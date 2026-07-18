import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/module_image_helper.dart';
import '../../providers/dashboard_provider.dart';

class ModuleCard extends StatelessWidget {
  final ModuleItem module;
  final VoidCallback? onTap;

  const ModuleCard({
    super.key,
    required this.module,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppTheme.primaryColor.withValues(alpha: 0.12),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image thumbnail ───────────────────────────────────────
            SizedBox(
              height: 110,
              width: double.infinity,
              child: Stack(
                children: [
                  // Module image (fills the full thumbnail area)
                  Image.asset(
                    ModuleImageHelper.assetPath(module.id),
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback: gradient tile with the module icon
                      return Container(
                        height: 110,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppTheme.primaryColor, AppTheme.darkGreen],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          module.icon,
                          color: Colors.white.withValues(alpha: 0.55),
                          size: 38,
                        ),
                      );
                    },
                  ),
                  // Bottom fade so the card body feels seamless
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
                            Colors.white.withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Progress badge (top-right corner)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${(module.progress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Text & progress ───────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.darkGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          module.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: module.progress,
                        minHeight: 5,
                        backgroundColor:
                            AppTheme.primaryColor.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
