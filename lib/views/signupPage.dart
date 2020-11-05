import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/service/auth_service.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailctr = TextEditingController();
  TextEditingController passctr = TextEditingController();

  AuthService authService = AuthService();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailctr,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey))),
                  validator: emailvalidator,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                TextFormField(
                  controller: passctr,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey))),
                  validator: passwordvalidator,
                ),
                RaisedButton(
                    child: Text('확인'),
                    onPressed: () {
                      submit();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String emailvalidator(value) {
    bool isWriteEmail = EmailValidator.validate(value);

    if (!isWriteEmail) {
      return '이메일형식에 맞게 입력해주세요';
    }
    return null;
  }

  String passwordvalidator(value) {
    if (value.isEmpty) {
      return "패스워드를 입력하세요";
    }

    if (value.length < 0) {
      return '비밀번호는 8자리로 입력해주세요';
    }
    return null;
  }

  void submit() {
    print(emailctr.text);

    if (globalKey.currentState.validate()) {
      String email = emailctr.text;
      String password = passctr.text;
      authService.signUp(email, password);
    }


    // if (email.isEmpty) {
    //   SnackBar snackBar = SnackBar(
    //     content: Text('이메일을 입력하세요'),
    //     duration: Duration(
    //       seconds: 1,
    //     ),
    //   );
    //   Scaffold.of(context).showSnackBar(snackBar);
    //   return;
    // }
    //
    // if (password.isEmpty && (password.length < 0)) {
    //   SnackBar snackBar = SnackBar(
    //     content: Text('페스워드를 입력하세요'),
    //     duration: Duration(
    //       seconds: 1,
    //     ),
    //   );
    //   Scaffold.of(context).showSnackBar(snackBar);
    //   return;
    // }

  }
}
