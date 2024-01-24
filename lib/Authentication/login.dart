// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:ezi_task_manager/Admin/admin_homepage.dart';
import 'package:ezi_task_manager/Authentication/authentication.dart';
import 'package:ezi_task_manager/Authentication/forget.dart';
import 'package:ezi_task_manager/Authentication/signup.dart';
import 'package:ezi_task_manager/Manager/manager_homepage.dart';
import 'package:ezi_task_manager/User/user_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Authentication authentication = Authentication();
  final loginFormKey = GlobalKey<FormState>();
  bool passShown = false;
  var passIcon = const Icon(Icons.visibility);
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String? email;
  String? password;
  bool _isHidden = true;
  String? selectedRole;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 45.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Login",
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
                          "Unlock the power of efficient management tool, Ezi Management",
                          softWrap: true,
                          style: TextStyle(fontSize: 14.h),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Email",
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
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.purple,
                              ),
                              prefixStyle: TextStyle(
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
                            onSaved: (newValue) {
                              email = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Text(
                        "Your Password",
                        style: TextStyle(fontSize: 14.h),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 45.w, top: 5.h),
                        child: Container(
                          width: 360.w,
                          height: 55.h,
                          child: TextFormField(
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(),
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.purple,
                              ),
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordVisibility,
                                icon: _isHidden
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.purple,
                                      ),
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
                            onSaved: (newValue) {
                              password = newValue;
                            },
                            controller: passController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ForgetPassword());
                          },
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 14.h),
                          ),
                        ),
                      ),

                      // Dropdown for selecting role
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
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
                            items: <String>[
                              'Select Role',
                              'Admin',
                              'Manager',
                              'User'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                        padding: EdgeInsets.only(
                          right: 45.w,
                          bottom: 20.h,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            color: Colors.purple,
                            height: 45.h,
                            minWidth: 280.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.r),
                            ),
                            onPressed: () async {
                              authentication.email = emailController.text;
                              authentication.password = passController.text;
                              authentication.selectedRole = selectedRole;

                              await authentication.signIn();
                              // Add logic here to navigate to the appropriate screen based on the role
                              if (authentication.signInSuccess) {
                                if (selectedRole == 'Admin') {
                                  Get.offAll(() => AdminHome());
                                } else if (selectedRole == 'Manager') {
                                  Get.offAll(() => ManagerHome());
                                } else if (selectedRole == 'User') {
                                  Get.offAll(() => UserHome());
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.h, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 45.w,
                          top: 5.h,
                          bottom: 20.h,
                        ),
                        child: Divider(
                          color: Colors
                              .black, // Set the color of the line (optional)
                          height: 1, // Set the height of the line (optional)
                          thickness:
                              1, // Set the thickness of the line (optional)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.h,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignUp());
                        },
                        child: Text(
                          " Register",
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
