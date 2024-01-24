// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProvideFeedback extends StatefulWidget {
  const ProvideFeedback({Key? key}) : super(key: key);

  @override
  _ProvideFeedbackState createState() => _ProvideFeedbackState();
}

class _ProvideFeedbackState extends State<ProvideFeedback> {
  List<String> taskNames = [];
  String selectedTaskName = '';
  late TextEditingController feedbackController;

  @override
  void initState() {
    super.initState();
    fetchAllTasks();
    feedbackController = TextEditingController();
  }

  Future<void> fetchAllTasks() async {
    try {
      QuerySnapshot<Object?> taskQuery =
          await FirebaseFirestore.instance.collection('tasks').get();

      if (taskQuery.docs.isNotEmpty) {
        setState(() {
          List<QueryDocumentSnapshot<Object?>> taskDocs =
              taskQuery.docs.cast<QueryDocumentSnapshot<Object?>>();

          taskNames =
              taskDocs.map((taskDoc) => taskDoc['name'] as String).toList();

          selectedTaskName = taskNames.first;
        });
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> provideFeedback() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .where('name', isEqualTo: selectedTaskName)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((taskDoc) {
          List<String> existingFeedback =
              List<String>.from(taskDoc['feedback'] ?? []);

          existingFeedback.add(feedbackController.text);

          taskDoc.reference.update({
            'feedback': existingFeedback,
          });
        });
      });
      Navigator.pop(context);
    } catch (e) {
      print('Error providing feedback: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provide Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedTaskName,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTaskName = newValue!;
                });
              },
              items: taskNames.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Feedback:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter feedback',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await provideFeedback();
              },
              child: Text('Provide Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
