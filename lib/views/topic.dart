import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/ui/showtags.dart';
import 'package:flutter_3line_diary/views/homePage.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  Database _database =Database();

  @override
  Widget build(BuildContext context) {
   final Color pColor = Color(0xff3EBAA9);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(page: 0)
            ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        centerTitle: true,
        title: Text('주제별 같이',
        style: GoogleFonts.nanumGothic(
        color: Colors.white,),
        ),
      ),
      body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'topic',
                style: GoogleFonts.nanumGothic(
                      color: pColor,
                      fontSize: 22,
                  fontWeight: FontWeight.w600
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
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future:  _database.listPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data;
          print(posts.length);
          return Container(
            height: size.height *0.65,
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
                      ShowTags(post.tags)
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
}
