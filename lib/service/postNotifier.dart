import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';

class PostNotifier with ChangeNotifier {
 List<Post> _postList = [];
 Post _currentPost;

 UnmodifiableListView<Post> get postList =>
 UnmodifiableListView(_postList);

 set postList(List<Post> postList) {
   _postList = postList;
   notifyListeners();
 }

 Post get currentPost => _currentPost;

set currentPost(Post post) {
  _currentPost = post;
  notifyListeners();
}

 deletePost(Post post) {
  _postList.removeWhere((_post) => _post.docId== post.docId);
  notifyListeners();
  }

}