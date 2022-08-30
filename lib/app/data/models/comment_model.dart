class Comment {
  String? by;
  int? id;
  List<int>? kids;
  int? parent;
  String? text;
  int? time;
  String? type;

  Comment(
      {this.by,
      this.id,
      this.kids,
      this.parent,
      this.text,
      this.time,
      this.type});

  Comment.fromJson(Map<String, dynamic> json) {
    by = json["by"];
    id = json["id"];
    kids = json["kids"] == null ? null : List<int>.from(json["kids"]);
    parent = json["parent"];
    text = json["text"];
    time = json["time"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["by"] = by;
    data["id"] = id;
    if (kids != null) data["kids"] = kids;
    data["parent"] = parent;
    data["text"] = text;
    data["time"] = time;
    data["type"] = type;
    return data;
  }
}
