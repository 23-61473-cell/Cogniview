class UserProfile {
  final String firstName;
  final String lastName;
  final String studentId;
  final String email;
  final String department;
  final String yearLevel;
  final String section;
  final String profilePicture;
  
  // Notification settings stored within the profile
  final bool lessonNotifications;
  final bool quizNotifications;
  final bool newModuleNotifications;
  final bool arScanNotifications;
  final bool generalAnnouncements;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.studentId,
    required this.email,
    this.department = 'Psychology',
    required this.yearLevel,
    required this.section,
    required this.profilePicture,
    this.lessonNotifications = true,
    this.quizNotifications = true,
    this.newModuleNotifications = true,
    this.arScanNotifications = true,
    this.generalAnnouncements = true,
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? studentId,
    String? email,
    String? department,
    String? yearLevel,
    String? section,
    String? profilePicture,
    bool? lessonNotifications,
    bool? quizNotifications,
    bool? newModuleNotifications,
    bool? arScanNotifications,
    bool? generalAnnouncements,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      department: department ?? this.department,
      yearLevel: yearLevel ?? this.yearLevel,
      section: section ?? this.section,
      profilePicture: profilePicture ?? this.profilePicture,
      lessonNotifications: lessonNotifications ?? this.lessonNotifications,
      quizNotifications: quizNotifications ?? this.quizNotifications,
      newModuleNotifications: newModuleNotifications ?? this.newModuleNotifications,
      arScanNotifications: arScanNotifications ?? this.arScanNotifications,
      generalAnnouncements: generalAnnouncements ?? this.generalAnnouncements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'studentId': studentId,
      'email': email,
      'department': department,
      'yearLevel': yearLevel,
      'section': section,
      'profilePicture': profilePicture,
      'lessonNotifications': lessonNotifications,
      'quizNotifications': quizNotifications,
      'newModuleNotifications': newModuleNotifications,
      'arScanNotifications': arScanNotifications,
      'generalAnnouncements': generalAnnouncements,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      studentId: json['studentId'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? 'Psychology',
      yearLevel: json['yearLevel'] ?? '',
      section: json['section'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      lessonNotifications: json['lessonNotifications'] ?? true,
      quizNotifications: json['quizNotifications'] ?? true,
      newModuleNotifications: json['newModuleNotifications'] ?? true,
      arScanNotifications: json['arScanNotifications'] ?? true,
      generalAnnouncements: json['generalAnnouncements'] ?? true,
    );
  }
}
