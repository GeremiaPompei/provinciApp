import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class StoreManager {

  static Future<File> localFile(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    return File(join(directory.path, fileName));
  }

  static Future<String> load(String fileName) async {
    File file = await localFile(fileName);
    return file.readAsString();
  }

  static Future store(String contents, String fileName) async {
    File file = await localFile(fileName);
    file.writeAsString(contents);
  }
}