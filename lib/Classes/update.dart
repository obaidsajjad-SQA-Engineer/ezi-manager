import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({Key? key}) : super(key: key);

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    taskDescriptionController = TextEditingController();
  }

  Future<void> fetchTaskDetails(String taskName) async {
    try {
      QuerySnapshot taskQuery = await FirebaseFirestore.instance
          .collection('tasks')
          .where('name', isEqualTo: taskName)
          .get();

      if (taskQuery.docs.isNotEmpty) {
        taskDescriptionController.text = taskQuery.docs.first['description'];
      }
    } catch (e) {
      print('Error fetching task details: $e');
    }
  }

  Future<void> updateTask(String taskName) async {
    try {
      // Update the task details in Firestore
      await FirebaseFirestore.instance
          .collection('tasks')
          .where('name', isEqualTo: taskName)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((taskDoc) {
          taskDoc.reference.update({
            'description': taskDescriptionController.text,
          });
        });
      });
      Navigator.pop(context);
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
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
              onPressed: () async {
                await fetchTaskDetails(taskNameController.text);
              },
              child: const Text('Fetch Task Details'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await updateTask(taskNameController.text);
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
