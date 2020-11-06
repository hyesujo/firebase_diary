import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/service/joinOrLogin.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/views/LoginPage.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
        providers: [
      ChangeNotifierProvider(
        create: (context) => PostNotifier(),
      ),
      ChangeNotifierProvider<JoinOrLogin>(
        create: (context) => JoinOrLogin(),
      ),
    ], child: MyApp()),
  );
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
      home: LoginPage(),
    );
  }
}
