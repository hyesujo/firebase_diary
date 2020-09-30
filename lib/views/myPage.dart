import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  MethodChannel methodChannel = MethodChannel('dev/flutter.io');

  void callMethod() async {
   var result = await methodChannel.invokeListMethod('add');
   print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children:[
        Text('MyPage'),
        RaisedButton(child: Text('text'),
        onPressed: callMethod,)
      ]
      ),
    );
  }
}
