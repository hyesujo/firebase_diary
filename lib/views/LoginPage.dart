import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/service/joinOrLogin.dart';
import 'package:flutter_3line_diary/ui/LoginBackGround.dart';
import 'package:flutter_3line_diary/ui/loginBackTwo.dart';
import 'package:flutter_3line_diary/views/forgetPassword.dart';
import 'package:flutter_3line_diary/views/homePage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emCtrl = TextEditingController();
  final TextEditingController _pwCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: size,
            painter: LoginBackTwo(),
          ),
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _loginImage, //이렇게 쓰려면 get을 하면됨(간단한 사용 =>)
              Stack(
                children: [
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.07,
              ),
              Consumer<JoinOrLogin>(
                builder:
                    (BuildContext context,JoinOrLogin joinOrLogin,Widget child) =>
                        GestureDetector(
                  onTap: () {
                    joinOrLogin.toggle();
                  },
                  child: Text(
                   joinOrLogin.isJoin? "계정이 있으시면 로그인해주세요":
                   "계정이 없으시면 생성하시겠어요?" ,
                    style: TextStyle(
                        color: joinOrLogin.isJoin ?
                    Colors.deepOrange
                            : Colors.deepPurple
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _register(BuildContext context) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emCtrl.text,
          password: _pwCtrl.text);
      final User user = credential.user;
      if(user == null) {
      final snackBar = SnackBar(
          content: Text("다시 시도해주세요!"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      }
    }on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        print('비밀번호의 보안이 취약합니다.');
        final snackBar = SnackBar(
          content: Text("비밀번호의 보안이 취약합니다."),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else if(e.code == 'email-already-in-use') {
        print("이미 사용중인 이메일 입니다.");
        final snackBar = SnackBar(
          content: Text("이미 사용중인 이메일 입니다."),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        print("sign up -$e");
      }
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            HomePage(page: 0)
    ));
  }

  void _login(BuildContext context) async {
    try{
      final UserCredential loginCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: _emCtrl.text,
          password: _pwCtrl.text);
      final User user = loginCredential.user;
      if(user ==null) {
        final SnackBar snackBar = SnackBar(
            content: Text("다시 시도해 주세요!"));
        Scaffold.of(context).showSnackBar(snackBar);
      }
    } catch(e) {
      print("Login - $e");
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (content)=>HomePage(page: 0)
    ),
    );
  }

  Widget get _loginImage => Expanded(
        child: Container(
          padding: EdgeInsets.only(
              top: 40,
          left: 30,
          right: 30),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/cat.gif'),
            ),
          ),
        ),
      );

  Widget _authButton(Size size) {
    return Positioned(
      left: size.width * 0.1,
      right: size.width * 0.1,
      bottom: 0,
      child: SizedBox(
        height: 40,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child) =>
              FlatButton(
            color: joinOrLogin.isJoin ?
            Colors.deepOrange
                : Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              joinOrLogin.isJoin ? "가입":
              "로그인",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    joinOrLogin.isJoin ?_register(context) : _login(context);
                  }
                }),
        ),
      ),
    );
  }


  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(
          size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(
              size.width * 0.02),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _emCtrl,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: "E-mail을 입력해주세요",
                  ),
                  validator: _emailValidator,
                ),
                TextFormField(
                    controller: _pwCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: "PassWord를 입력해주세요"),
                    validator: _pwValidator),
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.48,
                      top: 10,
                  right:5),
                  child: Consumer<JoinOrLogin>(
                    builder:(BuildContext context, JoinOrLogin joinOrLogin, Widget child)
                    =>Opacity(
                      opacity: joinOrLogin.isJoin ? 0:1,
                        child: GestureDetector(
                          onTap: joinOrLogin.isJoin ? null :(){
                            forgetPw(context);
                          },
                            child: Text(
                                "비밀번호를 잊었어요!"
                            ),
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 Function forgetPw(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ForgetPassword()));
  }

  String _emailValidator(value) {
    bool isWriteEmail = EmailValidator.validate(value);

    if (!isWriteEmail) {
      return "이메일 형식에 맞게 입력해주세요";
    }
    return null;
  }

  String _pwValidator(value) {
    if (value.isEmpty) {
      return "비밀번호를 입력해주세요";
    }
    if (value.length <= 0) {
      return "비밀번호는 최소 6글자에요";
    }
    return null;
  }



}
