import 'package:flutter/material.dart';

import 'signup_screen.dart';
import 'task_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would normally call your authentication logic, e.g., REST API
      // For simplicity, we navigate to the task list screen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    }
  }

  void _loginWithGoogle() {
    // Simulate social media login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskListScreen()),
    );
  }

  void _loginWithFacebook() {
    // Simulate social media login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'كلمة المرور'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال كلمة المرور';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('تسجيل الدخول'),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text('تسجيل الدخول باستخدام Google'),
                onPressed: _loginWithGoogle,
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text('تسجيل الدخول باستخدام Facebook'),
                onPressed: _loginWithFacebook,
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text('إنشاء حساب جديد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
