class NodeInfo{
  String name;
  String description;
  String url;
  String image;

  NodeInfo(this.name,this.description,this.url);

  String getName() => this.name;

  String getDescription() => this.description;

  String getUrl() => this.url;

  String getImage() => this.image;

  @override
  String toString(){
    if(description == null)
      return name;
    return name + ': ' + description;
  }
}