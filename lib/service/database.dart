import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_3line_diary/model/post.dart';

class Database {
  FirebaseFirestore _db = FirebaseFirestore.instance;



  Future<List<Post>> listPost() async{
  QuerySnapshot snapshot =
  await _db.collection('posts').limit(40).get();

  List<DocumentSnapshot> docs = snapshot.docs;

  List<Post> posts = docs.map((DocumentSnapshot snap) =>
      Post.fromMap(snap.data())).toList();

  return posts;
  }

  Future<List<Post>> listPostKeyword(String keyword) async{
    QuerySnapshot snapshot = await _db.collection('posts').where('searchKeyword',arrayContains:keyword).limit(10).get();

   List<DocumentSnapshot> docs = snapshot.docs;

   List<Post> post = docs.map((DocumentSnapshot snapshot) => Post.fromMap(snapshot.data())).toList();

   return post;
  }

  Future addPost(Post post) async {
  return await  _db.collection('posts').doc().set(post.toMap());
  }

  Future deletePost(Post post, Function postDeleted) async {
    if(post.photoUrl != null) {
      StorageReference storageReference =
      await FirebaseStorage.instance.getReferenceFromUrl(post.photoUrl);

      print("correctly url -${storageReference.path}");
      await storageReference.delete();

      print('image deleted');
    }

    await _db.collection("posts").doc(post.id).delete();
    postDeleted(post);
  }


}