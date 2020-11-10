class Post {
  String docId;
  String id;
  String title;
  String content;
  String photoUrl;
  int likes;
  List<String> tags = [];
  String time;

  Post({
    this.id,
    this.title,
    this.content,
    this.likes,
    this.photoUrl,
    this.tags,
    this.docId,
    this.time
  });

  Post.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.content = map['content'];
    this.photoUrl = map['photoUrl'];
    this.likes = map['likes'] ?? 0;
    this.time =map['Time'];
    if (map.containsKey('tags')) {
      this.tags = getTage(map['tags']);
    }
    if (map.containsKey('docId')) {
      this.docId = map['docId'];
    }
  }

  factory Post.fromFirbase(Map<String, dynamic> map) {

    return Post.fromMap(map);
  }


  List<String> getTage(List<dynamic> data) {

    return data.map((dynamic map) => map.toString()).toList();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['title'] = this.title;
    map['content'] = this.content;
    map['photoUrl'] = this.photoUrl;
    map['Time'] = this.time;
    map['likes'] = this.likes ?? 0;
    map['tags'] = this.tags ?? [];
    return map;
  }
}



