class Post {
  String title;
  String content;
  String photoUrl;
  int likes;
  List<String> tags = [];

  Post({
    this.title,
    this.content,
    this.likes,
    this.photoUrl,
    this.tags
  });

  Post.fromMap(Map map) {
    this.title = map['title'];
    this.content = map['content'];
    this.photoUrl = map['photoUrl'];
    this.likes = map['likes'] ?? 0;
    if (map.containsKey('tags')) {
      this.tags = getTage(map['tags']);
    }


  }


  List<String> getTage(List<dynamic> data) {

    return data.map((dynamic map) => map.toString()).toList();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['title'] = this.title;
    map['content'] = this.content;
    map['photoUrl'] = this.photoUrl;
    map['likes'] = this.likes ?? 0;
    map['tags'] = this.tags ?? [];
    return map;
  }
}

List<Post> mockPost = [
  Post(title: "은빛호수",
      content: "Google 번역 앱이 있으면 개인 통역기를 들고 다니는 것과 마찬가지입니다. 나만의 번역가. 오프라인으",
  photoUrl: 'https://previews.123rf.com/images/aberration/aberration1112/aberration111200020/11646777-%ED%99%94%EC%B0%BD%ED%95%9C-%EB%82%A0%EC%97%90-%ED%98%B8%EC%88%98%EC%9D%98-%EC%97%AC%EB%A6%84-%ED%92%8D%EA%B2%BD.jpg'),
  Post(title: '책',
      content: '책책책',
      photoUrl: 'https://file.mk.co.kr/mkde_7/N0/2019/09/20190911_4227439_1568163144.jpeg'),
  Post(title: '오리'
      , content: "꽥",
      photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bariloche-_Argentina2.jpg/300px-Bariloche-_Argentina2.jpg'),
  Post(title: '오리'
      , content: "꽥",
      photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bariloche-_Argentina2.jpg/300px-Bariloche-_Argentina2.jpg'),
];



