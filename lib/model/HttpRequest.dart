import 'dart:async';
import 'package:MC/model/NodeInfo.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<List<NodeInfo>> searchByWord(String word) async {
  Function fName = (html.Element el) =>
      el
          .getElementsByClassName('dataset-heading')
          .single
          .text
          .trim();
  Function fDescriprion = (html.Element el) =>
      el
          .getElementsByClassName('dataset-content')
          .single
          .getElementsByTagName('div')
          .single
          .text
          .trim();
  Function fUrl = (html.Element el) =>
      el
          .getElementsByClassName('label')
          .first
          .attributes
          .putIfAbsent('href', () => null)
          .trim();
  return getNodeInfo('dataset?q=' + word, 'dataset-list unstyled',
      'dataset-item', fName, fDescriprion, fUrl);
}

Future<List<NodeInfo>> organizations() async {
  Function fName = (html.Element el) =>
      el
          .getElementsByClassName('media-heading')
          .single
          .text
          .trim();
  Function fDescriprion = (html.Element el) =>
      el
          .getElementsByClassName('count')
          .single
          .text
          .trim();
  Function fUrl = (html.Element el) =>
      el
          .getElementsByClassName('media-view')
          .first
          .attributes
          .putIfAbsent('href', () => null)
          .trim();
  return getNodeInfo(
      'organization',
      'media-grid',
      'media-item',
      fName,
      fDescriprion,
      fUrl);
}

Future<List<NodeInfo>> categories() async {
  Function fName = (html.Element el) =>
      el
          .getElementsByClassName('media-heading')
          .single
          .text
          .trim();
  Function fDescriprion = (html.Element el) => null;
  Function fUrl = (html.Element el) =>
      el
          .getElementsByClassName('media-view')
          .first
          .attributes
          .putIfAbsent('href', () => null)
          .trim();
  return getNodeInfo(
      'group',
      'media-grid',
      'media-item',
      fName,
      fDescriprion,
      fUrl);
}

Future<List<NodeInfo>> getNodeInfo(String word,
    String ulClass,
    String liClass,
    String Function(html.Element) nameClass,
    String Function(html.Element) descriptionClass,
    String Function(html.Element) urlClass) async {
  List<NodeInfo> nodes = [];
  List<html.Element> elements = await getListInfo(word, ulClass, liClass);
  elements.forEach((element) {
    String name = nameClass(element);
    String description = descriptionClass(element);
    String url = urlClass(element);
    NodeInfo node = new NodeInfo(name, description, url);
    nodes.add(node);
  });
  return nodes;
}

Future<List<html.Element>> getListInfo(String word, String ulClass,
    String liClass) async {
  List<html.Element> elements = [];
  html.Document document;
  final response = await responseByGet(word);
  if (response.statusCode == 200) {
    document = parse(response.body);
    document.getElementsByClassName(ulClass).any((element) {
      element.getElementsByClassName(liClass).forEach((element) {
        elements.add(element);
      });
      return elements.isNotEmpty;
    });
  }
  return elements;
}

Future<http.Response> responseByGet(String word) {
  return http.Client().get(Uri.parse('http://dati.provincia.mc.it/' + word));
}
