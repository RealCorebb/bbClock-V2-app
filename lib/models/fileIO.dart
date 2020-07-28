import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bbClock/main.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileIO {
  Response response;
  Dio dio = new Dio();
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/alldata.json');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();
      print("Hey!I read the Data!");
      print(contents);
      alldata = jsonDecode(contents);
      return contents;
    } catch (e) {
      // If encountering an error, return 0
      print("Read ERROR");
      return null;
    }
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$data');
  }
}
