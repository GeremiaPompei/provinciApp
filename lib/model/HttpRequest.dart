import 'dart:async';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class HttpRequest {

  static Future<List<NodeInfo>> getNodeInfo(
      String word,
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

  static Future<List<html.Element>> getListInfo(
      String word, String ulClass, String liClass) async {
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

  static Future<http.Response> responseByGet(String word) {
    return http.Client().get(Uri.parse('http://dati.provincia.mc.it/' + word));
  }
}