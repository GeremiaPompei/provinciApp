import 'package:MC/model/HtmlParser.dart';
import 'package:MC/model/Ledger.dart';
import 'package:MC/model/NodeInfo.dart';

class Controller {

  Ledger ledger;

  Controller() {
    ledger = new Ledger();
    initOrganizations();
    initCategories();
  }

  void initOrganizations() async {
    this.ledger.initOrganizations(await HtmlParser.organizations());
  }

  void initCategories() async {
    this.ledger.initCategories(await HtmlParser.categories());
  }

  void setSearch(String word) async {
    this.ledger.setSearch(await HtmlParser.searchByWord(word));
  }

  List<NodeInfo> getOrganizations(){
    return this.ledger.organizations;
  }

  List<NodeInfo> getCategories(){
    return this.ledger.categories;
  }

  List<NodeInfo> getSearch(){
    return this.ledger.search;
  }

}