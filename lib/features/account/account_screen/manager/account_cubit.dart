import 'package:blog_app/core/models/user_data.dart';
import 'package:blog_app/core/storage/user_cache.dart';
import 'package:blog_app/core/storage/user_data_cache.dart';
import 'package:blog_app/shared/backend API/user_data_api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  Future<void> loadUser() async {
    emit(AccountLoading());
    try {
      final identity = await UserCache.get();
      if (identity.isExpired) {
        emit(AccountExpired());
        return;
      }
      if (identity.cached == null) {
        emit(AccountLoggedOut());
        return;
      }

      final response = await UserDataCache.get();

      if (response.isOk && response.cached != null) {
        emit(AccountLoaded(
          user: response.cached!,
          userId: identity.cached!.id
        ));
        return;
      }

      if (response.isExpired) {
        emit(AccountExpired());
        return;
      }

      final freshUser = await UserDataApi.getCurrentUserData();
      if (freshUser == null) {
        emit(AccountLoggedOut());
        return;
      }

      await UserDataCache.save(freshUser);
      emit(AccountLoaded(
          user: freshUser,
          userId: identity.cached!.id)
      );
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }
}
