import 'dart:async';
import 'package:flutter/material.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List> searchByWord(String word) async {
  List elements = new List<dynamic>();
  Document document;
  final response = await responseByGet('dataset?q=' + word);
  if (response.statusCode == 200) {
    document = parse(response.body);
    document.getElementsByClassName('dataset-list unstyled').any((element) {
      element.getElementsByClassName('dataset-heading').forEach((element) {
        elements.add(element.getElementsByTagName('a').single.text);
      });
      return elements.isNotEmpty;
    });
  }
  return elements;
}

Future<List> organizations() async {
  List elements = new List<dynamic>();
  Document document;
  final response = await responseByGet('organization');
  if (response.statusCode == 200) {
    document = parse(response.body);
    document.getElementsByClassName('media-grid').any((element) {
      element.getElementsByClassName('media-item').forEach((element) {
        elements.add(element.getElementsByClassName('media-heading').single.text);
      });
      return elements.isNotEmpty;
    });
  }
  return elements;
}

Future<List> categories() async {
  List elements = new List<dynamic>();
  Document document;
  final response = await responseByGet('group');
  if (response.statusCode == 200) {
    document = parse(response.body);
    document.getElementsByClassName('media-grid').any((element) {
      element.getElementsByClassName('media-item').forEach((element) {
        elements.add(element.getElementsByClassName('media-heading').single.text);
      });
      return elements.isNotEmpty;
    });
  }
  return elements;
}

Future<http.Response> responseByGet(String word) {
  return http.Client().get(Uri.parse('http://dati.provincia.mc.it/' + word));
}
