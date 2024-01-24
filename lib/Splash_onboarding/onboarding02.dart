import 'dart:async';

import 'package:ezi_task_manager/Authentication/signup.dart';
import 'package:ezi_task_manager/splash_onboarding/onboarding03.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding02 extends StatefulWidget {
  const Onboarding02({Key? key}) : super(key: key);

  @override
  State<Onboarding02> createState() => _Onboarding02State();
}

class _Onboarding02State extends State<Onboarding02> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SharedPreferences.getInstance().then((prefs) {
        bool showOnboarding = prefs.getBool('showHome') ?? true;

        if (showOnboarding) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Onboarding03()),
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
                "assets/images/onboarding02.png",
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Collaborate Efficiently",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(22),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Collaborate with your team in real-time. Receive updates instantly and work together to achieve your goals.",
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
