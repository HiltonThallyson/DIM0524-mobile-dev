import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DataHandler {
  static Future<File> getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/data.json");
  }

  static Future<String> readData() async {
    final file = await getFile();
    return file.readAsString();
  }

  static Future<File> saveData(List todoList) async {
    final file = await getFile();
    String data = json.encode(todoList);
    return file.writeAsString(data);
  }
}
