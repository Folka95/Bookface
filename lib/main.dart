import 'package:blog_app/features/main_screen/manager/main_cubit.dart';
import 'package:blog_app/features/main_screen/view/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';
import 'core/theme/theme_manager.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  // await googleSignIn.initialize(
  //   serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
  // );

  final themeManager = ThemeManager();
  await themeManager.loadThemeMode();
  themeManager.setThemeMode(ThemeMode.dark);

  // DioClient().initialize();

  runApp(MyApp(themeManager: themeManager));
}

class MyApp extends StatelessWidget {
  final ThemeManager themeManager;

  const MyApp({super.key, required this.themeManager});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeManager,
      builder: (context, child) {
        return MaterialApp(
          title: 'Blog App',

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeManager.themeMode,

          home: BlocProvider(
            create: (context) => MainCubit(),
            child: MainPage(),
          ),
        );
      },
    );
  }
}
