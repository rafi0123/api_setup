import 'package:flutter/material.dart';
import 'package:learn_api/home/example_complex.dart';
import 'package:learn_api/home/example_without_model.dart';
import 'package:learn_api/random_user_api_call/random_user.dart';
import 'package:learn_api/random_user_api_call/random_user_with_model.dart';
import 'package:learn_api/views/covid_19_app/splash_screen.dart';

import 'home/example1.dart';
import 'home/home_view.dart';

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
      home:const RandomUserWithNameModel(),
    );
  }
}
