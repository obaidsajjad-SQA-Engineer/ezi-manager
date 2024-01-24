// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  Future<void> createTask() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection('tasks').add({
          'name': taskNameController.text,
          'description': taskDescriptionController.text,
          'createdBy': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Navigator.pop(context);
      }
    } catch (e) {
      print('Error creating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Name:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                hintText: 'Enter task name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Task Description:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: taskDescriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter task description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createTask();
              },
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
