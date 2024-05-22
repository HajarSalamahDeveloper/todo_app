import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'task_model.dart';
import 'task_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task? task;

  TaskDetailScreen({this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  bool _isImportant = false;
  String _notes = '';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _isImportant = widget.task!.isImportant;
      _notes = widget.task!.notes;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Task task = Task(
        id: widget.task?.id ?? Uuid().v4(),
        title: _title,
        description: _description,
        dueDate: _dueDate,
        isImportant: _isImportant,
        notes: _notes,
      );
      if (widget.task == null) {
        Provider.of<TaskService>(context, listen: false).addTask(task);
      } else {
        Provider.of<TaskService>(context, listen: false).updateTask(task);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'إضافة مهمة جديدة' : 'تعديل المهمة'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'عنوان المهمة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال عنوان المهمة';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'وصف المهمة'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              ListTile(
                title: Text('تاريخ الاستحقاق'),
                subtitle: Text('${_dueDate.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _dueDate) {
                    setState(() {
                      _dueDate = picked;
                    });
                  }
                },
              ),
              SwitchListTile(
                title: Text('هل هي مهمة مهمة؟'),
                value: _isImportant,
                onChanged: (bool value) {
                  setState(() {
                    _isImportant = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _notes,
                decoration: InputDecoration(labelText: 'ملاحظات'),
                onSaved: (value) {
                  _notes = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('حفظ المهمة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
