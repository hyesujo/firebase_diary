import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

class FutureBuilderDetail extends StatefulWidget {
  Post post;

  FutureBuilderDetail({
    this.post
  });

  @override
  _FutureBuilderDetailState createState() => _FutureBuilderDetailState();
}

class _FutureBuilderDetailState extends State<FutureBuilderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            width: double.maxFinite,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                sharePost(widget.post);
              },
              icon: Icon(
                Icons.share,
                size: 36,
              ),
            ),
          )
          ],
        ),
      ),
    );
  }

  void sharePost(Post post) {
    Share.share(post.title, subject: post.content);
  }
}

