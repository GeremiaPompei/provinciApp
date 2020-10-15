import 'dart:async';
import 'package:MC/utility/ConstUrl.dart';

import 'HttpRequest.dart';

import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static Future<List<NodeInfo>> events() async {
    Function fName = (html.Element el) => el
        .getElementsByClassName('titolo_articolo_lista')
        .single
        .getElementsByTagName('a')
        .single
        .text
        .trim();
    Function fDescription =
        (html.Element el) => el.getElementsByTagName('p').single.text.trim();
    Function fUrl = (html.Element el) => el
        .getElementsByTagName('a')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .trim();
    Function fImage = (html.Element el) => el
        .getElementsByTagName('img')
        .first
        .attributes
        .putIfAbsent('src', () => null)
        .trim();
    return HttpRequest.getNodeInfo(
        MCEVENTI, 'articolo_lista', fName, fDescription, fUrl, fImage);
  }

  static Future<List<NodeInfo>> promos() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('grpn-dc-title').single.text.trim();
    Function fDescription = (html.Element el) =>
        el.getElementsByClassName('grpn-dc-loc').single.text.trim();
    Function fUrl = (html.Element el) => el
        .getElementsByTagName('a')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .trim();
    Function fImage = (html.Element el) => el
        .getElementsByTagName('img')
        .first
        .attributes
        .putIfAbsent('src', () => null)
        .trim();
    return HttpRequest.getNodeInfo(
        MCPROMO, 'deal-card', fName, fDescription, fUrl, fImage);
  }

  static Future<List<NodeInfo>> searchByWord(String url) async {
    Map<String, dynamic> map = await HttpRequest.getResource(url);
    List<NodeInfo> nodes = [];
    for (Map value in map['results']) {
      nodes.add(NodeInfo(value['title'], value['organization']['title'],
          value['resources'][1]['url'], null));
    }
    return nodes;
  }

  static Future<List<LeafInfo>> leafsByWord(String url) async {
    List<LeafInfo> list = [];
    dynamic body = await HttpRequest.getBody(url);
    try {
      for (int i = 0; i < body.length; i++) list.add(LeafInfo(body[i], url, i));
    } catch (e) {
      try {
        list.add(LeafInfo(body['MetaData'], url, 0));
      } catch (e) {}
    }
    return list;
  }

  static Future<List<Future<NodeInfo>>> organizations() async =>
      await _metaData(MCDATASET_ORGANIZATION_LIST, MCDATASET_ORGANIZATION_SHOW,
          MCDATASET_SEARCH + 'organization:');

  static Future<List<Future<NodeInfo>>> categories() async => await _metaData(
      MCDATASET_GROUP_LIST, MCDATASET_GROUP_SHOW, MCDATASET_SEARCH + 'groups:');

  static Future<List<Future<NodeInfo>>> _metaData(
      String list, String show, String url) async {
    List<dynamic> dataList = await HttpRequest.getResource(list);
    List<Future<NodeInfo>> nodes = dataList.map((id) async {
      Map map = await HttpRequest.getResource(show + id);
      return NodeInfo(map['display_name'], map['description'],
          url + map['name'], map['image_display_url'],
          isEmpty: map['package_count'] == 0);
    }).toList();
    return nodes;
  }
}
