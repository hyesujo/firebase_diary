

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_3line_diary/service/userDatabase.dart';

class AuthService {
 FirebaseAuth _auth = FirebaseAuth.instance;

 signUp(String email, String password) async {
   try {
     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password);
     print(userCredential);

     User user = userCredential.user;

     UserDatabase userDatabase = UserDatabase();

     print(user);

     userDatabase.addUser("이름", 30, user.uid);
   } catch (e) {
     print('sign up - $e');
   }
 }


 Future<Map> getUser() {
   String uid = _auth.currentUser.uid;
   UserDatabase userDatabase = UserDatabase();
   User user = _auth.currentUser;

   _auth.authStateChanges();
   return userDatabase.getUser(uid);

 }
 login() {

 }

 signOut() {

 }

 googleSignUp() {

 }

 faceBooksignUp() {

 }

 kakaoSignUp() {

 }
}