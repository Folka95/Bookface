import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/features/feed/models/feed.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      emit(ProfileFailure(message: "no cached user"));
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

      final db = FirebaseFirestore.instance;

      final doc = await db
          .collection("users")
          .doc(identity.cached!.id)
          .get();

      if (!doc.exists || doc.data() == null) {
        emit(ProfileLoggedOut());
        return;
      }

      final user = MyUserData.fromJson(
        doc.data()!,
      );

      await _saveAndEmit(user);
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> _loadOtherUser(String userId) async {
    final db = FirebaseFirestore.instance;

    final doc = await db
        .collection("users")
        .doc(userId)
        .get();

    if (!doc.exists || doc.data() == null) {
      emit(ProfileNotFound());
      return;
    }

    final user = MyUserData.fromJson(
      doc.data()!,
    );

    final posts = await _getPosts(userId);

    emit(
      ProfileLoaded(
        user: user,
        posts: posts,
      ),
    );
  }

  Future<void> _saveAndEmit(MyUserData user) async {
    await UserDataCache.save(user);

    final posts = await _getPosts(_profileUserId!);

    emit(
      ProfileLoaded(
        user: user,
        posts: posts,
      ),
    );
  }

  Future<void> _loadCached(MyUserData user) async {
    final posts = await _getPosts(_profileUserId!);

    emit(
      ProfileLoaded(
        user: user,
        posts: posts,
      ),
    );
  }

  Future<List<Feed>> _getPosts(String userId) async {
    final db = FirebaseFirestore.instance;

    final querySnapshot = await db
        .collection("posts")
        .where(
      "userId",
      isEqualTo: userId,
    )
        .get();

    final List<Feed> feed = [];

    for (final docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data();

      final post = {
        ...(data['post'] as Map<String, dynamic>),
        'id': docSnapshot.id,
      };

      feed.add(
        Feed.fromJson({
          ...data,
          'post': post,
        }),
      );
    }

    return feed;
  }
}