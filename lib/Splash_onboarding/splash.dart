// ignore_for_file: library_private_types_in_public_api

import 'package:ezi_task_manager/Authentication/login.dart';
import 'package:ezi_task_manager/splash_onboarding/onboarding01.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      SharedPreferences.getInstance().then((prefs) {
        bool showLogin = prefs.getBool('login') ?? false;
        if (showLogin) {
          Get.offAll(() => const Login());
        } else {
          Get.offAll(() => const Onboarding01());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 180.w,
        ),
      ),
    );
  }
}
