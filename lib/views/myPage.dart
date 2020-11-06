
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/myUser.dart';
import 'package:flutter_3line_diary/service/auth_service.dart';
import 'package:flutter_3line_diary/views/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  MyUser myuser = MyUser(
    id: 'hs',
    name: 'johyesu',
  email: 'poer611'
  );
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: true,
      child: Container(
        child: Column(
            children:[
          Center(child:
          Text('나의 세줄일기',
          textScaleFactor: 1.2,
          style: GoogleFonts.nanumMyeongjo(
            fontSize: 23.0,
            height: 1.5,
            fontWeight: FontWeight.bold
          ),
          )
          ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                    child: Text(
                  '하루를 둘러보며 나의 삶을 기록합니다.',
                  style: GoogleFonts.nanumMyeongjo(
                      fontSize: 14.0,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    color:Colors.grey[600]
                  ),
                ),
                ),
              ),
          Row(
            children: [
             Padding(
               padding: const EdgeInsets.only(
                   top: 60,
               left: 20
               ),
               child: Container(
                 width: 80,
                   height: 80,
                   child: Image.asset('assets/images/account.png')),
             ),
              Container(
                margin: EdgeInsets.only(left: 30,
                top: 70),
                height: 100,
                width: 0.5,
                child: VerticalDivider(
                  indent: 1.0,
                  width: 10,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50,
                left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                        child: Text('${myuser.name}세줄작가'),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10,
                        top: 5),
                        child: Text('안녕하세요')),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('${myuser.name}입니다.'),
                    ),
                    Row(
                      children: [
                        RaisedButton(
                            onPressed: (){},
                          color: Colors.blueGrey,
                        child: Text('프로필 수정',
                        style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage()));
                          },
                          color: Colors.grey,
                          child: Text('로그아웃',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
          // RaisedButton(child: Text('text'),
          // onPressed: callMethod,)
        ]
        ),
      ),
    );
  }
}


//
// MethodChannel methodChannel = MethodChannel('dev/flutter.io');
//
// void callMethod() async {
//  var result = await methodChannel.invokeListMethod('add');
//  print(result);
// }

// void getUser() async {
//   Map user = await authService.getUser();
//   print(user);
//
//
//   // if(user.containsKey('email')) {
//   //   myuser.email = user['email'] ?? 'email';
//   // }
//
//   myuser.name =user['name'] ?? 'name';
//
//   setState(() {
//     myuser;
//   });
// }
