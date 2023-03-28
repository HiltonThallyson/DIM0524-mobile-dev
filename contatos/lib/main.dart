import 'package:flutter/material.dart';

import 'screens/contact_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        ContactScreen.route: (context) => ContactScreen(),
      },
    ),
  );
}
