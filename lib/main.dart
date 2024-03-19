import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/firebase_options.dart';
import 'package:sample_project/screens/home/home_screen.dart';
import 'package:sample_project/screens/login/login_screen.dart';
import 'package:sample_project/utils/theme/app_theme.dart';
import 'package:sample_project/view_models/login_view_model.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => LoginViewModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppTheme.lightTheme,
        dark: AppTheme.darkTheme,
        initial: AdaptiveThemeMode.system,
        builder: (theme, darktheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darktheme,
            themeMode: ThemeMode.system,
            home: LoginScreen(),
          );
        });
  }
}