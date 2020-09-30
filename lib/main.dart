import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/views/mainPage.dart';
import 'package:flutter_3line_diary/views/myPage.dart';
import 'package:flutter_3line_diary/views/topic.dart';
import 'package:flutter_3line_diary/views/writePage.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(page: 0),
    );
  }
}

class HomePage extends StatefulWidget {

  final page;

  HomePage({
    this.page = 0,
});


  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _selectedIndex = 0;


  List<Widget> pages = [
    MainPage(),
    TopicPage(),
    WritePage(),
    MyPage(),
  ];

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
  }

  onTopic() {
    _firebaseMessaging.subscribeToTopic("english");
  }

  offTopic() {
    _firebaseMessaging.unsubscribeFromTopic("english");
  }

  getFCMToken() async {
 String token = await  _firebaseMessaging.getToken();
 print('token - $token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            title: Text('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            title: Text('Topic'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            title: Text('Write'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('My page'),
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _selectedIndex,
        onTap :_selectTab,
    )
    );
  }

  _selectTab(int index) {
  setState(() {
    this._selectedIndex = index;
  });
  }


}
