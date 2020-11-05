

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_3line_diary/service/auth_service.dart';
import 'package:flutter_3line_diary/views/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:image_picker/image_picker.dart';

class WritePage extends StatefulWidget {
  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _contentCtrl = TextEditingController();
  TextEditingController _tagCtrl = TextEditingController();
  final Color pColor = Color(0xff3EBAA9);
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  var uuid = Uuid();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Database database = Database();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: pColor,
            elevation: 0.0,
            title: Text('새 일기장 만들기',
            style: GoogleFonts.nanumGothic(
              fontSize: 20
            ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(
                    builder: (content)=>HomePage(page: 0)));
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: submit,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: _titleCtrl,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: '제목은 두줄로 적어주세요',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: TextFormField(
                    controller: _contentCtrl,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: '세줄일기',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        )
                    ),
                  ),
                ),
                tagField(),
                GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    color: Colors.black,
                    child: Center(
                      child: _imageFile != null ? Image.file(
                        File(_imageFile.path),)
                          : infoMessage(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: size.width *1,
                  height: size.height *0.06,
                  child: RaisedButton(
                      onPressed: (){
                        submit();
                      },
                    color: Colors.deepPurple,
                    child: Text("저장하기",
                    style: GoogleFonts.nanumGothic(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  Container tagField() {
    return Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: _tagCtrl,
                  decoration: InputDecoration(
                      hintText: '#당신의 삶 태그를 입력해주세요',
                      hintStyle: TextStyle(
                          color: pColor,
                          fontWeight: FontWeight.w300
                      ),
                  ),
                  onChanged: (value){
                    print(value);
                  },
                ),
              );
  }

  Column infoMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.picture_in_picture, color: Colors.white,
          size: 46,),
        Text('일기표지 이미지를 넣어주세요',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void submit() async {
    if (_titleCtrl.text.length == 0) {
      final snackbar = SnackBar(content: Text('제목을 적어주세요'),
        duration: Duration(seconds: 3),);
      Scaffold.of(context).showSnackBar(snackbar);
      return;
    }
    if (_contentCtrl.text.length == 0) {
      Flushbar(
        title: "안내 메세지",
        message: "내용을 적어주세요",
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: Duration(seconds: 2),)
        ..show(context);
    }
    if (_tagCtrl.text.length == 0) {
      Flushbar(
        title: "안내 메세지",
        message: "태그를 적어주세요",
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: Duration(seconds: 2),)
        ..show(context);
    }
     List<String> tags = getTag(_tagCtrl.text);
      String id = _auth.currentUser.uid;
      String content = _contentCtrl.text;
      String title = _titleCtrl.text;
      String photoUrl = await upLoad();
      Post post = Post(
        id: id,
        title: title,
        content: content,
        photoUrl: photoUrl,
        likes: 0,
        tags: tags,
      );
      await database.addPost(post);

      SnackBar snackBar = SnackBar(
        content: Text('새글이 작성되었습니다.'),
        duration: Duration(seconds: 1),
      );

      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (content)=>HomePage(page: 1),
      ),
      );
  }

  List<String> getTag(String text) {
  List<String> tags =text.split('#');

  tags = tags.where((String s) => s.isNotEmpty).toList();

  return tags;
  }


  Future<String> upLoad() async {
    if (_imageFile == null) {
      Flushbar(
        title:"안내 메세지",
        message: "이미지를 선택해주세요",
        flushbarPosition: FlushbarPosition.BOTTOM,
        duration: Duration(seconds: 1),
      )..show(context);
      return null;
    }
    final StorageReference storageReference  = FirebaseStorage().ref().child('forest/${uuid.v4()}');
    var data =await _imageFile.readAsBytes();
    StorageUploadTask uploadTask = storageReference.putData(data);
    uploadTask.events.listen((event) {
      print('upload event -$event, ${event.snapshot.error}');
    });

   StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

   String url = await storageTaskSnapshot.ref.getDownloadURL();
   print('url $url');

   return url;
  }

    void pickImage() async {
      PickedFile pickedFile =
      await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
