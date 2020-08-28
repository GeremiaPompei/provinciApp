import 'dart:async';
import 'dart:io';
import 'package:MC/model/NodeInfo.dart';
import 'package:MC/model/Persistence/StoreManager.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  static Future<String> getJson(String word) async {
    String element;
    html.Document document;
    if (!word.contains('Empty')) {
      final response = await _responseByGet(word);
      if (response.statusCode == 200) {
        document = parse(response.body);
        String url = document
            .getElementsByClassName('resources')
            .single
            .getElementsByClassName('resource-list')
            .single
            .getElementsByClassName('resource-item')[1]
            .getElementsByClassName('resource-url-analytics')
            .single
            .attributes
            .putIfAbsent('href', () => null)
            .trim();
        final response2 = await http.Client().get(Uri.parse(url));
        if (response2.statusCode == 200) {
          element = response2.body;
        }
      }
    }
    return element;
  }

  static Future<List<int>> getImage(String url) async {
    final response = await _responseByGet(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  }

  static Future<List<NodeInfo>> getNodeInfo(
      String word,
      String ulClass,
      String liClass,
      String Function(html.Element) nameClass,
      String Function(html.Element) descriptionClass,
      String Function(html.Element) urlClass,
      String Function(html.Element) imageClass) async {
    List<NodeInfo> nodes = [];
    List<html.Element> elements = await _getListInfo(word, ulClass, liClass);
    elements.forEach((element) {
      String name = nameClass(element);
      String description = descriptionClass(element);
      String url = urlClass(element);
      String image = imageClass(element);
      NodeInfo node = new NodeInfo(name, description, url, image);
      nodes.add(node);
    });
    return nodes;
  }

  static Future<List<html.Element>> _getListInfo(
      String word, String ulClass, String liClass) async {
    List<html.Element> elements = [];
    html.Document document;
    final response = await _responseByGet(word);
    if (response.statusCode == 200) {
      document = parse(response.body);
      if (ulClass == null)
        document.getElementsByClassName(liClass).forEach((element) {
          elements.add(element);
        });
      else
        document.getElementsByClassName(ulClass).any((element) {
          element.getElementsByClassName(liClass).forEach((element) {
            elements.add(element);
          });
          return elements.isNotEmpty;
        });
    }
    return elements;
  }

  static Future<http.Response> _responseByGet(String word) async {
    return await http.Client().get(Uri.parse(word));
  }
}
