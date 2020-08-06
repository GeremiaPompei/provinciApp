import 'package:MC/model/NodeInfo.dart';

class Ledger{
  List<NodeInfo> search = [];
  List<NodeInfo> organizations = [];
  List<NodeInfo> categories = [];

  void initOrganizations(List<NodeInfo> nodes){
    this.organizations = nodes;
  }

  void initCategories(List<NodeInfo> nodes){
    this.categories = nodes;
  }

  void setSearch(List<NodeInfo> nodes){
    this.search = nodes;
  }
}