import '../models/user_profile.dart';
import '../services/storage_service.dart';

class ProfileRepository {
  final StorageService _storageService;

  ProfileRepository(this._storageService);

  Future<UserProfile> getProfile() async {
    final cached = await _storageService.getProfile();
    if (cached != null) {
      return cached;
    }
    
    // Default initial mock profile
    final defaultProfile = UserProfile(
      firstName: 'Alex',
      lastName: 'Rivera',
      studentId: '21-04532',
      email: 'a.rivera@g.batstate-u.edu.ph',
      department: 'Psychology',
      yearLevel: '2nd Year',
      section: 'Section A',
      profilePicture: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&q=80&w=200',
    );
    await _storageService.saveProfile(defaultProfile);
    return defaultProfile;
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _storageService.saveProfile(profile);
  }

  Future<bool> verifyCurrentPassword(String currentPassword) async {
    final correctPassword = await _storageService.getPassword();
    return correctPassword == currentPassword;
  }

  Future<void> changePassword(String newPassword) async {
    await _storageService.savePassword(newPassword);
  }
}
