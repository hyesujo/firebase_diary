import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/service/searchdiarydelegate.dart';
import 'package:flutter_3line_diary/views/postDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Database _database =Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 32,
              ),
              onPressed: (){
                search();
              },
            ),
          ),
        ],
        title: Text(
          '다이어리',
          style: GoogleFonts.nanumGothic(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: showGirdPost(),
    );
  }

  Widget buildGridView({List post}) {
    List<Widget> item = buildItem(post);
    return GridView.count(
      childAspectRatio: 0.8,
      crossAxisCount: 3,
      children: buildItem(post),
    );
  }

  List<Widget> buildItem(List<Post> post) {
    List<Widget> widgets = [];

    for (int i = 0; i < post.length; i++) {
      Post posts = post[i];

      Widget w = GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
            builder: (BuildContext context) => PostDetail(post: posts,index: i,),
          ),
          );
        },
        child: Card(
          child: Container(
            width: 100,
            height: 130,
            color: Colors.black12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "${i}",
                  child: Image.network(
                    posts.photoUrl,
                    width: 130,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    posts.title,
                    maxLines: 1,
                    style: GoogleFonts.nanumGothic(
                      fontSize: 12,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      posts.content,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.nanumGothic(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      widgets.add(w);
    }
    return widgets;
  }

  void search() {
    showSearch(context: context,
        delegate: SearchPostDelegate());
  }
  Widget showGirdPost() {
    return FutureBuilder(
     future: _database.listPost(),
      builder: (BuildContext context, AsyncSnapshot snap) {
       if (snap.hasData) {
         List<Post> posts = snap.data;
         return GridView.builder(
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               crossAxisSpacing: 5.0,
               mainAxisSpacing: 5.0,
               childAspectRatio: 0.8,
             ),
             itemCount: posts.length,
             itemBuilder: (context,index) {
               Post post = posts[index];
               return Card(
                 child: Container(
                   width: 100,
                   height: 130,
                   color: Colors.black12,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Image.network(post.photoUrl,
                     width: 130,
                     height: 90,
                     fit: BoxFit.cover,
                   ),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 8),
                         child: Text(
                           post.title,
                           maxLines: 1,
                           style: GoogleFonts.nanumGothic(
                             fontSize: 12,
                           ),
                         ),
                       ),
                       Flexible(
                         child: Container(
                           padding: EdgeInsets.symmetric(horizontal: 8),
                           child: Text(
                             post.content,
                             overflow: TextOverflow.fade,
                             style: GoogleFonts.nanumGothic(fontSize: 12),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             }
           ,
         );
       }
       if(snap.hasError) {
         return Text('error ${snap.error}');
       }
       return Container();
      },
    );
  }
}


