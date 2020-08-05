class NodeInfo{
  String name;
  String description;
  String url;

  NodeInfo(this.name,this.description,this.url);

  @override
  String toString(){
    if(description==null)
      return name;
    return name + ': ' + description;
  }
}