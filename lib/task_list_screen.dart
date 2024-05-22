import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_detail_screen.dart';
import 'task_model.dart';
import 'task_service.dart';
import 'weekly_report_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  void _navigateToTaskDetail(Task? task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );
    if (result != null) {
      setState(() {});
    }
  }

  void _navigateToWeeklyReport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeeklyReportScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مدير المهام الذكي'),
        actions: [
          IconButton(
            icon: Icon(Icons.report),
            onPressed: _navigateToWeeklyReport,
          ),
        ],
      ),
      body: Consumer<TaskService>(
        builder: (context, taskService, child) {
          List<Task> tasks = taskService.getTasks();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Text(task.dueDate.toString()),
                onTap: () => _navigateToTaskDetail(task),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToTaskDetail(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
