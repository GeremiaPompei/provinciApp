import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class StoreManager {

  static Future<File> localFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return File(join(directory.path, "cache.json"));
  }

  static Future<String> load() async {
    File file = await localFile();
    return file.readAsString();
  }

  static Future store(String contents) async {
    File file = await localFile();
    file.writeAsString(contents);
  }
}
