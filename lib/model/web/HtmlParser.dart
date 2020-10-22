import 'dart:async';
import 'package:provinciApp/utility/ConstUrl.dart';

import 'HttpRequest.dart';

import 'package:provinciApp/model/risorsa.dart';
import 'package:provinciApp/model/pacchetto.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static Future<List<Pacchetto>> events() async {
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

  static Future<List<Pacchetto>> promos() async {
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

  static Future<List<Pacchetto>> searchByWord(String url) async {
    Map<String, dynamic> map = await HttpRequest.getResource(url);
    List<Pacchetto> nodes = [];
    for (Map value in map['results']) {
      nodes.add(Pacchetto(value['title'], value['organization']['title'],
          value['resources'][1]['url']));
    }
    return nodes;
  }

  static Future<List<Risorsa>> leafsByWord(String url) async {
    List<Risorsa> list = [];
    dynamic body = await HttpRequest.getBody(url);
    try {
      for (int i = 0; i < body.length; i++) list.add(Risorsa(body[i], url, i));
    } catch (e) {
      try {
        list.add(Risorsa(body['MetaData'], url, 0));
      } catch (e) {}
    }
    return list;
  }

  static Future<List<Future<Pacchetto>>> organizations() async =>
      await _metaData(MCDATASET_ORGANIZATION_LIST, MCDATASET_ORGANIZATION_SHOW,
          MCDATASET_SEARCH + 'organization:');

  static Future<List<Future<Pacchetto>>> categories() async => await _metaData(
      MCDATASET_GROUP_LIST, MCDATASET_GROUP_SHOW, MCDATASET_SEARCH + 'groups:');

  static Future<List<Future<Pacchetto>>> _metaData(
      String list, String show, String url) async {
    List<dynamic> dataList = await HttpRequest.getResource(list);
    return dataList.map((id) async {
      Map map = await HttpRequest.getResource(show + id);
      return Pacchetto(
          map['display_name'], map['description'], url + map['name'],
          immagineUrl: map['image_display_url'],
          isEmpty: map['package_count'] == 0);
    }).toList();
  }
}
