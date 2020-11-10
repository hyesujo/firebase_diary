import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/ui/showtags.dart';
import 'package:flutter_3line_diary/views/FavoritePage.dart';
import 'package:flutter_3line_diary/views/homePage.dart';
import 'package:flutter_3line_diary/views/togetherPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopicPage extends StatefulWidget {
  final List<Post> favoritePost;

  TopicPage(this.favoritePost);
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    final Color pColor = Color(0xff3EBAA9);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: pColor,
            unselectedLabelColor: Colors.white60,
            indicatorWeight: 3.0,
            tabs: [Tab(text: '모두의 일기책'), Tab(text: '좋아하는 일기책')],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage(page: 0)),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            '주제별 같이',
            style: GoogleFonts.nanumGothic(
              color: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            TogetherPage(),
            FavoritePage(widget.favoritePost),
          ],
        ),
      ),
    );
  }
}
