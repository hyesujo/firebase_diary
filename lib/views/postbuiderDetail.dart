import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/views/writePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


class PostDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[800],
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                color: Colors.white,
              ),
                  onPressed: () {
                Navigator.of(context).pop();
              }),
            ),
            Spacer(),
            IconButton(
                icon: Icon(Icons.share,
            color: Colors.white
            ), onPressed: () {
              sharePost(postNotifier.currentPost);
            }),
            IconButton(icon: Icon(
              Icons.more_vert,
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
             postNotifier.currentPost.photoUrl,
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitWidth,
            ),
            Text(
              postNotifier.currentPost.content,
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
    PostNotifier postNotifier = Provider.of(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  onTap: () {
                    postNotifier.currentPost = null;
                    Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (BuildContext context) => WritePage()));
                  },
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
                  // onTap: () => database.deletePost(, postDeleted)
                ),
              ],
            ),
          );
        });
  }


}

