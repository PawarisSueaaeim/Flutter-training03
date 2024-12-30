import 'package:flutter/material.dart';
import 'package:flutter_training04/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Training",
      theme: ThemeData.dark(),
      home: const LoginPage()
    );
  }
}
