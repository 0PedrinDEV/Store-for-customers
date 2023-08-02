import 'package:flutter/material.dart';
import 'package:loja/Login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Flutter",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const LoginPage(),
      // LoginPage
    );
  }
}
