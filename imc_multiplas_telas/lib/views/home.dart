import 'dart:math';

import 'package:flutter/material.dart';

import '/views/result.dart';

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
    final imc = peso / (pow(altura, 2));
    String texto;
    String imagem;
    setState(() {
      _textInfo = imc.toStringAsPrecision(4);
    });

    if (imc < 18.5) {
      texto = "Abaixo do peso, imc=$_textInfo";
      imagem = "assets/images/thin.jpg";
    } else if (imc < 24.9) {
      texto = "Peso normal, imc=$_textInfo";
      imagem = "assets/images/normal.jpg";
    } else {
      texto = "Acima do peso, imc=$_textInfo";
      imagem = "assets/images/fat.jpg";
    }

    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => Result(imagem, texto))));
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
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 40)),
                        onPressed: () => _formKey.currentState!.validate()
                            ? _calcular()
                            : null,
                        child: const Text(
                          "Calcular",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
