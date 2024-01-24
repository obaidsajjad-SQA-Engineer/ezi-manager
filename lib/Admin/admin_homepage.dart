import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezi_task_manager/Classes/create_task.dart';
import 'package:ezi_task_manager/Classes/delete_task.dart';
import 'package:ezi_task_manager/Classes/feedback_task.dart';
import 'package:ezi_task_manager/Classes/read_task.dart';
import 'package:ezi_task_manager/Classes/update.dart';
import 'package:ezi_task_manager/Authentication/authentication.dart';
import 'package:ezi_task_manager/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late String userRole;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  Future<void> fetchUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userRole = userDoc['role'];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching user role: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: Center(
        child: isLoading ? const CircularProgressIndicator() : buildAdminUI(),
      ),
    );
  }

  Widget buildAdminUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (userRole == 'Admin') ...[
          ElevatedButton(
            onPressed: () {
              Get.to(() => const CreateTask());
            },
            child: const Text('Create Task'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const ReadTask());
            },
            child: const Text('Read Tasks'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const UpdateTask());
            },
            child: const Text('Update Task'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const DeleteTask());
            },
            child: const Text('Delete Task'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => const ProvideFeedback());
            },
            child: const Text('Provide Feedback on Tasks'),
          ),
          ElevatedButton(
            onPressed: () {
              Authentication().signOut();
              Get.offAll(() => const Login());
            },
            child: const Text('Logout'),
          ),
        ],
      ],
    );
  }
}
