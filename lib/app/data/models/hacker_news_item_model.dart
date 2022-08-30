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
    by = json["by"];
    descendants = json["descendants"];
    id = json["id"];
    kids = json["kids"] == null ? null : List<int>.from(json["kids"]);
    score = json["score"];
    time = json["time"];
    title = json["title"];
    type = json["type"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["by"] = by;
    data["descendants"] = descendants;
    data["id"] = id;
    if (kids != null) data["kids"] = kids;
    data["score"] = score;
    data["time"] = time;
    data["title"] = title;
    data["type"] = type;
    data["url"] = url;
    return data;
  }
}
