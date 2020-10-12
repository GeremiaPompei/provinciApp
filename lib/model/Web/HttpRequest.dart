import 'dart:async';
import 'dart:convert';

import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  static Future<dynamic> getResource(String url) async {
    Map<String, dynamic> map = await getBody(url);
    if (map['success']) return await map['result'];
  }

  static Future<dynamic> getBody(String url) async {
    final response = await _responseByGet(url);
    return await json.decode(response.body);
  }

  static Future<List<int>> getImage(String url) async {
    final response = await _responseByGet(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  }

  static Future<List<NodeInfo>> getNodeInfo(
      String word,
      String liClass,
      String Function(html.Element) nameClass,
      String Function(html.Element) descriptionClass,
      String Function(html.Element) urlClass,
      String Function(html.Element) imageClass) async {
    List<NodeInfo> nodes = [];
    List<html.Element> elements = await _getListInfo(word, liClass);
    elements.forEach((element) {
      try {
        String name = nameClass(element);
        String description = descriptionClass(element);
        String url = urlClass(element);
        String image = imageClass(element);
        NodeInfo node = new NodeInfo(name, description, url, image);
        nodes.add(node);
      } catch (e) {}
    });
    return nodes;
  }

  static Future<List<html.Element>> _getListInfo(
      String word, String liClass) async {
    List<html.Element> elements = [];
    html.Document document;
    final response = await _responseByGet(word);
    if (response.statusCode == 200) {
      document = parse(response.body, encoding: 'utf-8');
      document.getElementsByClassName(liClass).forEach((element) {
        elements.add(element);
      });
    }
    return elements;
  }

  static Future<http.Response> _responseByGet(String word) async {
    return await http.Client().get(Uri.parse(word));
  }
}
