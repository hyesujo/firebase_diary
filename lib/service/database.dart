import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_3line_diary/model/post.dart';

class Database {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Post>> listPost() async{
  QuerySnapshot snapshot =
  await _db.collection('posts').limit(10).get();

  List<DocumentSnapshot> docs = snapshot.docs;

  List<Post> posts = docs.map((DocumentSnapshot snap) =>
      Post.fromMap(snap.data())).toList();

  return posts;
  }

  Future addPost(Post post) async {
  return await  _db.collection('posts').doc('1000').set(post.toMap());
  }
}