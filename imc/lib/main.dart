import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora IMC",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetCampos() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calcular() {
    final peso = double.parse(pesoController.text);
    final altura = double.parse(alturaController.text) / 100;
    ;
    final imc = peso / (pow(altura, 2));

    setState(() {
      _textInfo = imc.toStringAsPrecision(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
        actions: [
          IconButton(onPressed: _resetCampos, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Peso(Kg)",
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.green)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira um peso";
                      } else if (double.parse(value) < 0) {
                        return "Insira um peso válido";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle:
                            TextStyle(fontSize: 25, color: Colors.green)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira uma altura";
                      } else if (double.parse(value) < 0) {
                        return "Insira uma altura válida";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () => _formKey.currentState!.validate()
                            ? _calcular()
                            : null,
                        child: const Text(
                          "Calcular",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_textInfo != "")
                    Text(
                      'Imc calculado: $_textInfo',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
