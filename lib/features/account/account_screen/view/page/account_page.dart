import 'package:blog_app/features/account/account_screen/manager/account_cubit.dart';
import 'package:blog_app/features/account/account_screen/view/widget/account_settings.dart';
import 'package:blog_app/features/account/account_screen/view/widget/short_info.dart';
import 'package:blog_app/shared/widgets/invalid_credits_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_message.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCubit()..loadUser(),
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountExpired) {
            AppMessage.show(
              context,
              message: "Last session has expired",
              type: AppMessageType.warning,
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case AccountInitial():
            case AccountLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );

            case AccountFailure():
              return Center(
                child: Text(state.message),
              );

            case AccountExpired():
              return const InvalidCredentialsLoginPage();

            case AccountLoggedOut():
              return const InvalidCredentialsLoginPage();

            case AccountLoaded():
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShortInfoPage(user: state.user),

                    const SizedBox(height: 16),

                    AccountSettingsPage(
                        user: state.user,
                        userId: state.userId,
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}