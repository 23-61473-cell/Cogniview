import 'package:flutter/material.dart';
import 'chapter_model.dart';

/// Represents a learning module with its associated chapters.
class ModuleModel {
  final String id;
  final String title;
  final String description;
  final double progress; // 0.0 to 1.0
  final IconData icon;
  final bool isLocked;
  final List<ChapterModel> chapters;

  const ModuleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.icon,
    this.isLocked = false,
    this.chapters = const [],
  });
}
