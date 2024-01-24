import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadTask extends StatefulWidget {
  const ReadTask({Key? key}) : super(key: key);

  @override
  _ReadTaskState createState() => _ReadTaskState();
}

class _ReadTaskState extends State<ReadTask> {
  late Stream<QuerySnapshot> tasksStream;

  @override
  void initState() {
    super.initState();
    tasksStream = FirebaseFirestore.instance.collection('tasks').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Tasks'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tasksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return buildTaskList(snapshot.data?.docs ?? []);
          }
        },
      ),
    );
  }

  Widget buildTaskList(List<DocumentSnapshot> tasks) {
    if (tasks.isEmpty) {
      return Center(
        child: Text('No tasks available'),
      );
    } else {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var task = tasks[index].data() as Map<String, dynamic>;
          var feedbackList = task['feedback'] as List<dynamic>? ?? [];

          return ListTile(
            title: Text(task['name'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task['description'] ?? ''),
                if (feedbackList.isNotEmpty)
                  Text('Feedback: ${feedbackList.join(", ")}')
                else
                  Text('No feedbacks given'),
              ],
            ),
          );
        },
      );
    }
  }
}
