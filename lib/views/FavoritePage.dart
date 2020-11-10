import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/ui/showtags.dart';
import 'package:flutter_3line_diary/views/postbuiderDetail.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  final List<Post> favoritePost;

  FavoritePage(this.favoritePost);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("좋아하는 일기가 없어요!"),
    );
  }
}
