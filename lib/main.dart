import 'package:flutter/material.dart';
import 'package:learn_api/random_user_api_call/test.dart';
import 'package:learn_api/random_user_api_call/user_random.dart';
import 'package:learn_api/todo_app/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: '',
      // This splash screen will be for Covid 19 App
      // home: const SplashScreen(),

      // This is api call is for random user api
      // home: const Test(),

      // This is api call is for todo app

      home: const ToDoList(),
    );
  }
}
