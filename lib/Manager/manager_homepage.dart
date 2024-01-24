import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezi_task_manager/Authentication/authentication.dart';
import 'package:ezi_task_manager/Classes/create_task.dart';
import 'package:ezi_task_manager/Classes/feedback_task.dart';
import 'package:ezi_task_manager/Classes/read_task.dart';
import 'package:ezi_task_manager/Classes/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Authentication/login.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  late String userRole;
  late Future<void> userRoleFuture;

  @override
  void initState() {
    super.initState();
    userRoleFuture = fetchUserRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Home'),
      ),
      body: FutureBuilder(
        future: userRoleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle error state
            return const Center(
              child: Text('Error fetching user role'),
            );
          } else {
            return buildManagerUI();
          }
        },
      ),
    );
  }

  Widget buildManagerUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (userRole == 'Manager') ...[
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
      ),
    );
  }

  Future<void> fetchUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Retrieve user role from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userRole = userDoc['role'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }
}
