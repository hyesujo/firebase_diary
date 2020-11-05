import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';


class FutureBuilderDetail extends StatefulWidget {
  final Post post;

  FutureBuilderDetail({
    this.post
  });

  @override
  _FutureBuilderDetailState createState() => _FutureBuilderDetailState();
}

class _FutureBuilderDetailState extends State<FutureBuilderDetail> {
  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[800],
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                color: Colors.white,
              ),
                  onPressed: () {
                Navigator.of(context).pop();
              }),
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.share,
            color: Colors.white,), onPressed: () {
              sharePost(widget.post);
            }),
            IconButton(icon: Icon(Icons.more_vert,
            color: Colors.white,),
                onPressed: () {
              _bottomList(context);
                }
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Image.network(
              widget.post.photoUrl,
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitWidth,
            ),
            Text(
              widget.post.content,
              style: GoogleFonts.nanumGothic(fontSize: 14, height: 1.5),
            ),
          Flexible(
            child: Container(),
          ),
          ],
        ),
      ),
    );
  }

  void sharePost(Post post) {
    Share.share(post.title, subject: post.content);
  }
  
  void _bottomList(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text("일기 수정"),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey[500],
                  thickness: 1,
                  indent: 15.0,
                  endIndent: 30.0,
                ),
                ListTile(
                  title: Text("일기장 삭제"),
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }

  void _onPostDeleted(Post post) {
    Navigator.of(context);
  }
}

