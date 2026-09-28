import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/shared/data/gender_data.dart';
import 'package:blog_app/shared/data/interests_data.dart';

class UserDataApi {
  static MyUserData? _currentUser;
  static String? _currentUserId;

  static Future<MyUserData?> getCurrentUserData() async {
    final identity = await UserCache.get();
    final userId = identity.cached?.id;
    if (userId == null) {
      return null;
    }
    if (_currentUserId != userId || _currentUser == null) {
      _currentUserId = userId;
      _currentUser = await UserDataApi._getUserDataById(userId);
    }
    return _currentUser;
  }

  static Future<MyUserData?> getUserDataById(String userId) async {
    final identity = await UserCache.get();
    if (identity.cached?.id == userId) {
      return UserDataApi.getCurrentUserData();
    }

    if (!UserDataApi._isValidMockUserId(userId)) {
      return null;
    }

    return UserDataApi._getUserDataById(userId);
  }

  static Future<MyUserData?> updateCurrentUserData(MyUserData user) async {
    final identity = await UserCache.get();
    if (identity.cached == null) {
      return null;
    }
    _currentUserId = identity.cached!.id;
    _currentUser = user;
    return _currentUser;
  }

  static Future<MyUserData> _getUserDataById(String userId) async {
    return MyUserData(
      email: '$userId@example.com',
      name: userId == 'user_other_1' ? 'Sara Ahmed' : 'Mocked User',
      profileImage: 'https://i.pravatar.cc/300?img=20',
      about: 'This is a mocked profile.',
      gender: Genders.male,
      nationality: 'Egypt',
      interests: const [Interests.personal],
      birthdate: DateTime(2000, 12, 31),
      createdAt: DateTime(2018, 3, 15),
      lastActive: DateTime(2026, 1, 1),
    );
  }

  static bool _isValidMockUserId(String userId) {
    return RegExp(r'^user_other_[1-5]$').hasMatch(userId);
  }
}
