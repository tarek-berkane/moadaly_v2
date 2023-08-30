import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getLocalPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<bool> saveInitData(String fileName, Map noteData) async {
  try {
    String rawData = json.encode(noteData);
    String localPath = await getLocalPath();

    File file = File("$localPath/$fileName.json");
    await file.writeAsString(rawData);
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
  return true;
}

Future<Map?> loadInitData(String fileName) async {
  String localPath = await getLocalPath();
  File file = File("$localPath/$fileName.json");
  if (await file.exists()) {
    String rawData = await file.readAsString();
    Map data = json.decode(rawData);
    return data;
  }
  return null;
}

Future<bool?> deleteInitData(String fileName) async {
  String localPath = await getLocalPath();
  File file = File("$localPath/$fileName.json");
  if (await file.exists()) {
    await file.delete();
    return true;
  }
  return false;
}

Future<Map> loadSchema(fileName) async {
  final String response =
      await rootBundle.loadString('assets/json/$fileName.json');
  Map data = await json.decode(response);
  return data;
}
