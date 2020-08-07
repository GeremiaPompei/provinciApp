import 'dart:async';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static Future<List<NodeInfo>> searchByWord(String word) async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('dataset-heading').single.text.trim();
    Function fDescriprion = (html.Element el) => el
        .getElementsByClassName('dataset-content')
        .single
        .getElementsByTagName('div')
        .single
        .text
        .trim();
    Function fUrl = (html.Element el) => el
        .getElementsByClassName('label')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .trim();
    return HttpRequest.getNodeInfo(word, 'dataset-list unstyled',
        'dataset-item', fName, fDescriprion, fUrl);
  }

  static Future<List<NodeInfo>> organizations() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('media-heading').single.text.trim();
    Function fDescriprion = (html.Element el) =>
        el.getElementsByClassName('count').single.text.trim();
    Function fUrl = (html.Element el) => el
        .getElementsByClassName('media-view')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .trim();
    return HttpRequest.getNodeInfo(
        'organization', 'media-grid', 'media-item', fName, fDescriprion, fUrl);
  }

  static Future<List<NodeInfo>> categories() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('media-heading').single.text.trim();
    Function fDescriprion = (html.Element el) => null;
    Function fUrl = (html.Element el) => el
        .getElementsByClassName('media-view')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .trim();
    return HttpRequest.getNodeInfo(
        'group', 'media-grid', 'media-item', fName, fDescriprion, fUrl);
  }
}