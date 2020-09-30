import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  Database _database =Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        centerTitle: true,
        title: Text('주제별 같이',
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text('topic',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22
                ),
                ),
              ),
              showPost(),
            ],
          )
      ),
    );
  }

  Widget showPost() {
    return FutureBuilder(
      future:  _database.listPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data;
          print(posts.length);
          return Container(
            height: 300,
            child: ListView.builder(
              itemCount: posts.length,
                itemBuilder: (context, index){
                  Post post = posts[index];
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Image.network(
                          post.photoUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(post.title),
                      SizedBox(
                        height: 5,
                      ),
                      showTag(post.tags)
                      ],
                      )
                    ),
                  );
                }),
          );
        } if(snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        return Container();
      },
    );
  }
  Widget showTag(List<String> tags){
    String text ='';

    for(var i=0; i < tags.length; i++){
      text += "#${tags[i]}";
    }
    return Text(text,style: TextStyle(color: Colors.blue,
    fontSize: 13),
    );
  }
}
