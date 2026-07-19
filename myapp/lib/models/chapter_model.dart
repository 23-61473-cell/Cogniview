/// Represents a single chapter belonging to a learning module.
class ChapterModel {
  final int chapterNumber;
  final String title;
  final String content; // Placeholder lesson content

  const ChapterModel({
    required this.chapterNumber,
    required this.title,
    this.content = '',
  });
}
