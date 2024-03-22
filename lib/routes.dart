import 'package:flutter/material.dart';
import 'package:sample_project/screens/auth/login_screen.dart';
import 'package:sample_project/screens/auth/register_screen.dart';
import 'package:sample_project/screens/tabs/categories/add_category/add_category_screen.dart';
import 'package:sample_project/screens/tabs/products/add_product/add_product_screen.dart';
import 'package:sample_project/screens/tabs/tab_screen.dart';

import 'screens/splash/splash_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.addProductRoute:
        return navigate(const AddProductScreen());

      case RouteNames.addCategoryRoute:
        return navigate(AddCategoryScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      case RouteNames.loginRoute:
        return navigate(const LoginScreen());

      case RouteNames.registerRoute:
        return navigate(const RegisterScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String loginRoute = "/login_route";
  static const String registerRoute = "/register_route";
  static const String addProductRoute = "/add_product_route";
  static const String addCategoryRoute = "/add_category_route";
}
