import 'dart:async';
import 'HttpRequest.dart';

import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static final String MCDATI = 'http://dati.provincia.mc.it/api/3/action/';
  static final String MCEVENTI =
      'https://www.cronachemaceratesi.it/category/archivi/eventi-spettacoli/';
  static final String MCPROMO = 'https://www.groupon.it/offerte/macerata/';

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
      nodes.add(NodeInfo(value['title'], value['maintainer'],
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

  static Future<List<NodeInfo>> organizations() async => await _metaData(
      'organization', MCDATI + 'package_search?rows=1000&q=organization:');

  static Future<List<NodeInfo>> categories() async =>
      await _metaData('group', MCDATI + 'package_search?rows=1000&q=groups:');

  static Future<List<NodeInfo>> _metaData(String type, String prelink) async {
    List<dynamic> list = await HttpRequest.getResource(MCDATI + type + '_list');
    List<NodeInfo> nodes = [];
    for (String id in list) {
      Map<String, dynamic> map = await
          HttpRequest.getResource(MCDATI + type + '_show?id=' + id);
      if (map['package_count'] > 0) {
        nodes.add(NodeInfo(map['display_name'], map['description'],
            prelink + map['name'], map['image_display_url']));
      }
    }
    return nodes;
  }
}
