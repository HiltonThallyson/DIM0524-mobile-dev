import 'package:flutter/material.dart';

import '../controllers/api_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, dynamic>?> apiData;
  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();
  final _realNode = FocusNode();
  final _dolarNode = FocusNode();
  final _euroNode = FocusNode();
  double? dolar, euro;

  @override
  void initState() {
    super.initState();
    dolar = 0;
    euro = 0;
    apiData = ApiController.getData();
  }

  @override
  void dispose() {
    super.dispose();
    _realNode.dispose();
    _dolarNode.dispose();
    _euroNode.dispose();
  }
  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   apiData = await ApiController.getData() as Future<Map<String, dynamic>>;
  // }

  void _clearAll() {
    _realController.text = "";
    _dolarController.text = "";
    _euroController.text = "";
    _realNode.unfocus();
    _dolarNode.unfocus();
    _euroNode.unfocus();
  }

  void _convertFromReal(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(_realController.text);
    setState(() {
      _dolarController.text = (real / dolar!).toStringAsFixed(2);
      _euroController.text = (real / euro!).toStringAsFixed(2);
    });
  }

  void _convertFromDolar(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(value);
    setState(() {
      _realController.text = (dolar * this.dolar!).toStringAsFixed(2);
      _euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
    });
  }

  void _convertFromEuro(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(value);
    setState(() {
      _realController.text = (euro * this.euro!).toStringAsFixed(2);
      _dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
    });
  }

  Widget buildTextField(String label, String prefix,
      TextEditingController controller, Function function, FocusNode node) {
    return TextField(
      focusNode: node,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.amber),
        prefixText: "$prefix ",
        prefixStyle: const TextStyle(color: Colors.amber),
        fillColor: Colors.amber,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
      style: const TextStyle(color: Colors.amber, fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) => function(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("\$ Conversor de Moedas \$"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: apiData,
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:

              case ConnectionState.active:

              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    "Erro ao carregar os dados",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                }
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      buildTextField("Reais", "R\$", _realController,
                          _convertFromReal, _realNode),
                      const Divider(),
                      buildTextField("Dólar", "US\$", _dolarController,
                          _convertFromDolar, _dolarNode),
                      const Divider(),
                      buildTextField("Euro", "EUR", _euroController,
                          _convertFromEuro, _euroNode),
                    ],
                  ),
                );
            }
          })),
    );
  }
}
