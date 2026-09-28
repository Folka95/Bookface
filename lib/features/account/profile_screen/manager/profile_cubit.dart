import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/shared/backend API/user_data_api.dart';
import 'package:blog_app/shared/backend API/post_api.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  String? _profileUserId;

  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile(String userId) async {
    _profileUserId = userId;
    emit(ProfileLoading());
    try {
      final identity = await UserCache.get();
      if (identity.isExpired) {
        emit(ProfileExpired());
        return;
      }
      if (identity.cached?.id != userId) {
        await _loadOtherUser(userId);
        return;
      }

      final response = await UserDataCache.get();
      if (response.isOk && response.cached != null) {
        await _loadCached(response.cached!);
        return;
      }

      final freshUser = await UserDataApi.getCurrentUserData();
      if (freshUser == null) {
        emit(ProfileLoggedOut());
        return;
      }

      await _saveAndEmit(freshUser);
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> refreshProfile() async {
    emit(ProfileLoading());
    try {
      final identity = await UserCache.get();
      if (identity.isExpired) {
        emit(ProfileExpired());
        return;
      }
      if (identity.cached?.id != _profileUserId) {
        if (_profileUserId == null) {
          emit(ProfileNotFound());
          return;
        }
        await _loadOtherUser(_profileUserId!);
        return;
      }

      final freshUser = await UserDataApi.getCurrentUserData();
      if (freshUser == null) {
        emit(ProfileLoggedOut());
        return;
      }
      await _saveAndEmit(freshUser);
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> _loadOtherUser(String userId) async {
    final user = await UserDataApi.getUserDataById(userId);
    if (user == null) {
      emit(ProfileNotFound());
      return;
    }
    final posts = await PostAPI.getPostsByUser(userId);
    emit(ProfileLoaded(user: user, posts: posts));
  }

  Future<void> _saveAndEmit(MyUserData user) async {
    await UserDataCache.save(user);
    final posts = await PostAPI.getCurrentUserPosts();
    emit(ProfileLoaded(user: user, posts: posts));
  }

  Future<void> _loadCached(MyUserData user) async {
    final posts = await PostAPI.getCurrentUserPosts();
    emit(ProfileLoaded(user: user, posts: posts));
  }
}
