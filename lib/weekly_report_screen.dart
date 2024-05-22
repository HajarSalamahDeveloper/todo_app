import 'package:flutter/material.dart';

import 'task_model.dart';
import 'task_service.dart';

class WeeklyReportScreen extends StatelessWidget {
  final TaskService _taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
    List<Task> tasks = _taskService
        .getTasks()
        .where((task) => task.dueDate.isAfter(oneWeekAgo))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('تقرير الأسبوع'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Text(task.dueDate.toString()),
          );
        },
      ),
    );
  }
}
