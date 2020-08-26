import 'dart:async';
import 'dart:convert';
import 'package:MC/model/LeafInfo.dart';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static final String MCDATI = 'http://dati.provincia.mc.it/';
  static final String MCEVENTI =
      'https://www.cronachemaceratesi.it/category/archivi/eventi-spettacoli/';
  static final String MCPROMO = 'https://www.groupon.it/offerte/marche/';

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
    return HttpRequest.getNodeInfo(
        MCEVENTI, null, 'articolo_lista', fName, fDescription, fUrl);
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
    return HttpRequest.getNodeInfo(
        MCPROMO, null, 'deal-card', fName, fDescription, fUrl);
  }

  static Future<List<NodeInfo>> searchByWord(String word) async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('dataset-heading').single.text.trim();
    Function fDescription = (html.Element el) => el
        .getElementsByClassName('dataset-content')
        .single
        .getElementsByTagName('div')
        .single
        .text
        .trim();
    Function fUrl = (html.Element el) => (MCDATI +
        (el
            .getElementsByClassName('label')
            .first
            .attributes
            .putIfAbsent('href', () => null)
            .trim()));
    return HttpRequest.getNodeInfo(MCDATI + word, 'dataset-list unstyled',
        'dataset-item', fName, fDescription, fUrl);
  }

  static Future<List<LeafInfo>> leafsByWord(String word) async {
    List<LeafInfo> list = [];
    try {
      List<dynamic> tmp = json.decode(await HttpRequest.getJson(word));
      for (int i = 0; i < tmp.length; i++) list.add(LeafInfo(tmp[i], word, i));
    } catch (e) {
      try {
        Map<String, dynamic> tmp = json.decode(await HttpRequest.getJson(word));
        list.add(LeafInfo(tmp['MetaData'], word, 0));
      } catch (e) {}
    }
    return list;
  }

  static Future<List<NodeInfo>> organizations() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('media-heading').single.text.trim();
    Function fDescription = (html.Element el) =>
        el.getElementsByClassName('count').single.text.trim();
    Function fUrl = (html.Element el) => ((el
        .getElementsByClassName('media-view')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .substring(1)
        .trim()));
    return HttpRequest.getNodeInfo(MCDATI + 'organization', 'media-grid',
        'media-item', fName, fDescription, fUrl);
  }

  static Future<List<NodeInfo>> categories() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('media-heading').single.text.trim();
    Function fDescription = (html.Element el) => null;
    Function fUrl = (html.Element el) => ((el
        .getElementsByClassName('media-view')
        .first
        .attributes
        .putIfAbsent('href', () => null)
        .substring(1)
        .trim()));
    return HttpRequest.getNodeInfo(MCDATI + 'group', 'media-grid', 'media-item',
        fName, fDescription, fUrl);
  }
}
