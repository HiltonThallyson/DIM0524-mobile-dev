import 'package:flutter/material.dart';

import 'views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          headline5: TextStyle(
              fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
          headline3: TextStyle(
            fontSize: 26,
            color: Colors.purple,
          ),
        ),
      ),
      title: "MyApp",
      home: const MainScreen(),
    );
  }
}
