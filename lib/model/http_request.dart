import 'dart:async';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List> fetchWord(String search) async {
  List elements = new List<dynamic>();
  Document document;
  final response = await http.Client()
      .get(Uri.parse('http://dati.provincia.mc.it/dataset?q=' + search));
  if (response.statusCode == 200) {
    document = parse(response.body);
    document.getElementsByClassName('dataset-list unstyled').any((element) {
      element.getElementsByClassName('dataset-heading').forEach((element) {
        elements.add(element.getElementsByTagName('a').single.text);
      });
      return true;
    });
  }
  return elements;
}
