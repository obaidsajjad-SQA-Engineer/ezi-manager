// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:ezi_task_manager/Authentication/authentication.dart';
import 'package:ezi_task_manager/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final signupFormKey = GlobalKey<FormState>();
bool passShown = false;
var passIcon = const Icon(Icons.visibility);
final emailController = TextEditingController();
final passController = TextEditingController();
final nameController = TextEditingController();
String? selectedRole;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signupFormKey,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 45.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "SignUp",
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
                          "Create an account to access all the features of Ezi Mnagement!",
                          softWrap: true,
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30.h,
                        ),
                        child: Text(
                          "Email",
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 10.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.purple,
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
                      Text(
                        "Your Name",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 10.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.purple,
                              ),
                              hintText: "Ex. Obaid Sajjad",
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
                      Text(
                        "Your Password",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextField(
                            controller: passController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.purple,
                              ),
                              hintText: "**********",
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
                    left: 45.w,
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
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    color: Colors.purple,
                    height: 45.h,
                    minWidth: 280.w,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    onPressed: () async {
                      // Set values in the Authentication class
                      authentication.email = emailController.text;
                      authentication.name = nameController.text;
                      authentication.password = passController.text;
                      authentication.selectedRole = selectedRole;

                      // Call signUp method from Authentication class
                      await authentication.signUp();
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('login', true);
                      Get.offAll(
                        () => Login(),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16.h, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.h,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Login());
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.h,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
