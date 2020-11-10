import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/views/homePage.dart';
import 'package:flutter_3line_diary/views/writePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class PostDetail extends StatefulWidget {
  int index;

  PostDetail({this.index});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Database _database = Database();

  List<Post> _favoritePosts = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PostNotifier postNotifier =
        Provider.of<PostNotifier>(context, listen: false);

    _onPostDeleted(Post post) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage(page: 0)));
    }

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
                icon: Icon(
                  _isFavorite(postNotifier.currentPost.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  _toggleFavorite(postNotifier.currentPost.id);
                }),
            IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  sharePost(postNotifier.currentPost);
                }),
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {
                  selectBottom(context, postNotifier, _onPostDeleted);
                }),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: postNotifier.currentPost,
              child: Image.network(
                postNotifier.currentPost.photoUrl,
                width: double.infinity,
                height: 400,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(left: size.width * 0.04),
              child: Text(
                postNotifier.currentPost.content,
                style: GoogleFonts.nanumGothic(
                    fontSize: 20, fontWeight: FontWeight.w500, height: 1.5),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: size.width * 0.75,
                top: size.height * 0.2,
              ),
              child: Text(postNotifier.currentPost.time.toString(),
                  style: GoogleFonts.nanumGothic(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ),
            Flexible(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void selectBottom(BuildContext context, PostNotifier postNotifier,
      _onPostDeleted(Post post)) {
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
                        builder: (BuildContext context) => WritePage(),
                      ),
                    );
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
                    onTap: () => _database.deletePost(
                        postNotifier.currentPost, _onPostDeleted)),
              ],
            ),
          );
        });
  }

  void sharePost(Post post) {
    Share.share(post.title, subject: post.content);
  }

  void _toggleFavorite(String postId) {
    PostNotifier postNotifier =
        Provider.of<PostNotifier>(context, listen: false);
    int initIndex = this._favoritePosts.indexWhere((post) => post.id == postId);
    if (initIndex >= 0) {
      setState(() {
        _favoritePosts.removeAt(initIndex);
      });
    } else {
      setState(() {
        _favoritePosts
            .add(postNotifier.postList.firstWhere((post) => post.id == postId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoritePosts.any((post) => post.id == id);
  }
}
