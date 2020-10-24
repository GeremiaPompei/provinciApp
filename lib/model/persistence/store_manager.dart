import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Uno StoreManager da la possibilità di leggere, scrivere ed accedere nel
/// file system.
class StoreManager {
  /// Metodo utile per prelevare un file dato il suo nome.
  Future<File> getFile(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    return File(join(directory.path, fileName));
  }

  /// Metodo utile per prelevare una directory dato il suo nome.
  Future<Directory> getDirectory(String dirName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    return Directory(join(directory.path, dirName));
  }

  /// Metodo utile per leggere una stringa da un file.
  Future<String> leggiFile(String fileName) async {
    File file = await getFile(fileName);
    return file.readAsString();
  }

  /// Metodo utile per scrivere un file in memoria e ritornare il suo path.
  Future<String> scriviFile(String contents, String fileName) async {
    File file = await getFile(fileName);
    file.writeAsString(contents);
    return file.path;
  }

  /// Metodo utile per scrivere un gruppo di bytes in un file e ritornare il
  /// suo path.
  Future<String> scriviBytes(List<int> contents, String fileName) async {
    File file = await getFile(fileName);
    file.writeAsBytes(contents);
    return file.path;
  }
}
