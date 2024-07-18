import 'package:elearning_app/pages/login_page.dart';
import 'package:elearning_app/pages/signup_page.dart';
import 'package:elearning_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/loginpage': (context) => LoginPage(),
        '/signuppage': (context) => SignupPage(),
        '/dashboardscreenpage': (context) => DashBoardScreen(),
      },
    );
  }
}