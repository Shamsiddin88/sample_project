import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample_project/routes.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../utils/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 4),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Lottie.asset(AppImages.loading),
        ),
      ),
    );
  }
}
