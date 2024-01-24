// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    String? selectedRole;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 34.h,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 45.w),
                      child: Text(
                        "Recover your password if you have forgot the password!",
                        softWrap: true,
                        style: TextStyle(fontSize: 16.h),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 30.h,
                        ),
                        child: Text(
                          "Verification code",
                          style: TextStyle(fontSize: 16.h),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 45.w,
                        top: 5.h,
                        bottom: 30.h,
                      ),
                      child: Container(
                        width: 360.w,
                        height: 55.h,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.purple,
                            ),
                            prefixStyle: TextStyle(
                              color: Colors.purple,
                              fontSize: 12.h,
                            ),
                            hintText: "Ex: abc@example.com",
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontStyle: FontStyle.italic,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5.w,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 2.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Dropdown for selecting role
              Padding(
                padding: EdgeInsets.only(
                  right: 45.w,
                  bottom: 20.h,
                  left: 35.w,
                ),
                child: Container(
                  width: 360.w,
                  height: 55.h,
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: const Icon(
                        Icons.arrow_downward,
                      ),
                    ),
                    isExpanded: true,
                    iconSize: 24,
                    elevation: 16,
                    borderRadius: BorderRadius.circular(20.r),
                    style: TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRole = newValue;
                      });
                    },
                    items: <String>['Select Role', 'Admin', 'Manager', 'User']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 20),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.purple,
                      ),
                      hintText: "Select Role",
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontStyle: FontStyle.italic,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1.5.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 45.w, right: 45.w),
                child: MaterialButton(
                  color: Colors.purple,
                  height: 45.h,
                  minWidth: 280.w,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  onPressed: () async {},
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16.h, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showForgetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Check Email",
            style: TextStyle(
              fontSize: 34.h,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
              "We have sent an email to your email account with a verification Link!"),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "NOTE: Try Forget Password again if you did'nt get the link!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              minimumSize: Size(360.w, 55.h),
            ),
            onPressed: () {
              Get.to(() => Login());
            },
            child: Text(
              "Continue",
              style: TextStyle(
                fontSize: 14.h,
              ),
            ),
          ),
        ],
      ));
    },
  );
}
