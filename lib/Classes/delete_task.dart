// ignore_for_file: avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteTask extends StatefulWidget {
  const DeleteTask({Key? key}) : super(key: key);

  @override
  _DeleteTaskState createState() => _DeleteTaskState();
}

class _DeleteTaskState extends State<DeleteTask> {
  late TextEditingController taskNameController;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
  }

  Future<void> deleteTask(String taskName) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .where('name', isEqualTo: taskName)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((taskDoc) {
          taskDoc.reference.delete();
        });
      });
      Navigator.pop(context);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Task'),
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
            ElevatedButton(
              onPressed: () async {
                await deleteTask(taskNameController.text);
              },
              child: const Text('Delete Task'),
            ),
          ],
        ),
      ),
    );
  }
}
