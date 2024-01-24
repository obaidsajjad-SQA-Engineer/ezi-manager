import 'dart:async';

import 'package:ezi_task_manager/Authentication/signup.dart';
import 'package:ezi_task_manager/splash_onboarding/onboarding02.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding01 extends StatefulWidget {
  const Onboarding01({Key? key}) : super(key: key);

  @override
  State<Onboarding01> createState() => _Onboarding01State();
}

class _Onboarding01State extends State<Onboarding01> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SharedPreferences.getInstance().then((prefs) {
        bool showOnboarding = prefs.getBool('showHome') ?? true;

        if (showOnboarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Onboarding02()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 280.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                "assets/images/onboarding01.png",
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Ezi Task Manager",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Manage your tasks seamlessly with our user-friendly interface. Create, update, and complete tasks effortlessly.",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.h,
              ),
              MaterialButton(
                color: Colors.purple,
                height: 45.h,
                minWidth: 280.w,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', true);
                  prefs.setBool('login', true);
                  Get.offAll(() => const SignUp());
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 16.h, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
