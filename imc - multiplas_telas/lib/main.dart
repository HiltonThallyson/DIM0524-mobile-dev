import 'package:flutter/material.dart';

import 'views/home.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const Home(),
  ));
}
