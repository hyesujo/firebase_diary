import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emCtrl,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: "E-mail을 입력해주세요",
              ),
              validator: _emailValidator,
            ),
            FlatButton(
                onPressed: () async {
                 await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emCtrl.text);
                 final SnackBar snackBar = SnackBar(
                   content: Text("비밀번호 설정 이메일을 보냈습니다!"),
                 );
                 Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
                  },
                child: Text('비밀번호 재설정 이메일받기'),
            ),
          ],
        ),
      ),
    );
  }

  String _emailValidator(value) {
    bool isWriteEmail = EmailValidator.validate(value);

    if (!isWriteEmail) {
      return "이메일 형식에 맞게 입력해주세요";
    }
    return null;
  }

}
