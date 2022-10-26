import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/data_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _todoList = [];
  final _todoController = TextEditingController();
  Map<String, dynamic> _lastRemoved = Map();
  int _lastRemovedPos = 0;

  @override
  void initState() {
    super.initState();
    DataHandler.readData().then((data) {
      setState(() {
        _todoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTodo = {};
      newTodo["title"] = _todoController.text;
      newTodo["ok"] = false;
      _todoList.add(newTodo);
      _todoController.text = "";
      DataHandler.saveData(_todoList);
    });
  }

  void _removeToDo(int index) {
    _lastRemoved = Map.from(_todoList[index]);
    _lastRemovedPos = index;
    setState(() {
      _todoList.removeAt(index);
      DataHandler.saveData(_todoList);
    });
  }

  void _cancelarRemocao() {
    setState(() {
      _todoList.insert(_lastRemovedPos, _lastRemoved);
      DataHandler.saveData(_todoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de tarefas"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        labelText: "Nome da tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addToDo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
                  background: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) {
                    _removeToDo(index);
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Tarefa ${_lastRemoved["title"]} removida.",
                      ),
                      action: SnackBarAction(
                          label: "Desfazer", onPressed: _cancelarRemocao),
                      duration: const Duration(seconds: 2),
                    ));
                  },
                  child: CheckboxListTile(
                    contentPadding: const EdgeInsets.only(left: 0),
                    title: Text(
                      _todoList[index]["title"],
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                    secondary: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(_todoList[index]["ok"]
                            ? Icons.check
                            : Icons.error)),
                    value: _todoList[index]["ok"],
                    onChanged: ((value) {
                      setState(() {
                        _todoList[index]["ok"] = !_todoList[index]["ok"];
                        DataHandler.saveData(_todoList);
                      });
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
