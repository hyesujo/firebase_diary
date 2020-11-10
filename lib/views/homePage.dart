import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/views/mainPage.dart';
import 'package:flutter_3line_diary/views/myPage.dart';
import 'package:flutter_3line_diary/views/topic.dart';
import 'package:flutter_3line_diary/views/writePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  final page;
  final List<Post> favoritePost;
  HomePage({
    this.page = 0,
    this.favoritePost,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _selectedIndex = 0;
  List<Widget> pages;
  @override
  void initState() {
    _selectedIndex = widget.page;
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    onTopic();
    getFCMToken();
    pages = [
      MainPage(),
      TopicPage(widget.favoritePost),
      WritePage(),
      MyPage(),
    ];
  }

  onTopic() {
    _firebaseMessaging.subscribeToTopic("english");
  }

  offTopic() {
    _firebaseMessaging.unsubscribeFromTopic("english");
  }

  getFCMToken() async {
    String token = await _firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style),
              label: 'Topic',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'Write',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'My page',
            ),
          ],
          backgroundColor: Colors.black,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey[500],
          currentIndex: _selectedIndex,
          onTap: _selectTab,
        ));
  }

  _selectTab(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }
}
