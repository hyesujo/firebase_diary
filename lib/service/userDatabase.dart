import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase {
   FirebaseFirestore _db = FirebaseFirestore.instance;
   final String collection = 'user';

   addUser(String name, int age, String uid) {

      Map<String, dynamic> data = Map();
      data['age'] = age;
      data['name'] = name;

     _db.collection(collection).doc(uid).set(data);
   }

   Future<Map> getUser(String uid) async {
      DocumentSnapshot snapshot = await _db.collection(collection).doc(uid).get();
      return snapshot.data();
   }
}