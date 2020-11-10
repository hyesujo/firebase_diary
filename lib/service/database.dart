import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';

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
  return await _db.collection('posts').doc().set(post.toMap());
  }

  Future deletePost(Post post, Function postDeleted) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    if(post.photoUrl != null) {
      StorageReference storageReference =
      await FirebaseStorage.instance
          .getReferenceFromUrl(post.photoUrl);
      print("correctly url -${storageReference.path}");
      try{
        await storageReference.delete();
      } catch (e) {
        print('notDelete -$e');
      }
      print('image deleted');
    }
    try {
      await _db.collection("posts").doc(post.docId).delete();
     return postDeleted(post);
    }catch(e){
      print('doc Delete-$e');
    }


  }


  Future getPost(PostNotifier postNotifier) async {
     QuerySnapshot snap = await _db
         .collection('posts').limit(40).get();

     List<Post> _postList = [];
     
     snap.docs.forEach((document) {
       Map map = document.data();
       map['docId'] = document.id;

       Post post = Post.fromFirbase(map);
       _postList.add(post);
     });

     return postNotifier.postList = _postList;
  }
}

