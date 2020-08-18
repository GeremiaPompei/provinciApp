import 'dart:async';
import 'package:MC/model/web/HttpRequest.dart';
import 'package:MC/model/NodeInfo.dart';
import 'package:html/dom.dart' as html;

class HtmlParser {
  static final String MCDATI = 'http://dati.provincia.mc.it/';
  static final String MCEVENTI =
      'https://www.cronachemaceratesi.it/category/archivi/eventi-spettacoli/';

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

  static Future<List<NodeInfo>> organizations() async {
    Function fName = (html.Element el) =>
        el.getElementsByClassName('media-heading').single.text.trim();
    Function fDescription = (html.Element el) =>
        el.getElementsByClassName('count').single.text.trim();
    Function fUrl = (html.Element el) => (
        (el
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
    Function fUrl = (html.Element el) => (
        (el
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
