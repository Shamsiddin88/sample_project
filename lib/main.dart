import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/services/firebase_options.dart';
import 'package:sample_project/services/local_notification_service.dart';
import 'package:sample_project/utils/permission_utils/app_permissions.dart';
import 'package:sample_project/view_models/image_view_model.dart';
import 'package:sample_project/view_models/news_view_model.dart';
import 'package:sample_project/view_models/notification_view_model.dart';
import 'data/local/storage_repository.dart';
import 'routes.dart';
import 'utils/theme/app_theme.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/category_view_model.dart';
import 'view_models/products_view_model.dart';
import 'view_models/tab_view_model.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesViewModel()),
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => ImageViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
