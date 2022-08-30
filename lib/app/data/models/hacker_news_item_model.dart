class HackerNewsItem {
  String? by;
  int? descendants;
  int? id;
  List<int>? kids;
  int? score;
  int? time;
  String? title;
  String? type;
  String? url;

  HackerNewsItem(
      {this.by,
      this.descendants,
      this.id,
      this.kids,
      this.score,
      this.time,
      this.title,
      this.type,
      this.url});

  HackerNewsItem.fromJson(Map<String, dynamic> json) {
    this.by = json["by"];
    this.descendants = json["descendants"];
    this.id = json["id"];
    this.kids = json["kids"] == null ? null : List<int>.from(json["kids"]);
    this.score = json["score"];
    this.time = json["time"];
    this.title = json["title"];
    this.type = json["type"];
    this.url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["by"] = this.by;
    data["descendants"] = this.descendants;
    data["id"] = this.id;
    if (this.kids != null) data["kids"] = this.kids;
    data["score"] = this.score;
    data["time"] = this.time;
    data["title"] = this.title;
    data["type"] = this.type;
    data["url"] = this.url;
    return data;
  }
}
