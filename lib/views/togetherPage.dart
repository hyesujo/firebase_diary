import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/ui/showtags.dart';
import 'package:flutter_3line_diary/views/postbuiderDetail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TogetherPage extends StatefulWidget {
  @override
  _TogetherPageState createState() => _TogetherPageState();
}

class _TogetherPageState extends State<TogetherPage> {
  Database _database = Database();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);
    _database.getPost(postNotifier);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color pColor = Color(0xff3EBAA9);
    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'topic',
            style: GoogleFonts.nanumGothic(
                color: pColor, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        showPost(context),
      ],
    ));
  }

  Widget showPost(BuildContext context) {
    PostNotifier postNotifier =
        Provider.of<PostNotifier>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Flexible(
      child: ListView.builder(
          itemCount: postNotifier.postList.length,
          itemBuilder: (context, index) {
            return Container(
              height: size.height * 0.2,
              child: Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PostDetail()));
                  },
                  child: Card(
                    elevation: 0.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          postNotifier.postList[index].photoUrl,
                          width: size.width * 0.2,
                          height: size.height * 0.16,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postNotifier.postList[index].title,
                                style: TextStyle(fontSize: 16),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child:
                                    ShowTags(postNotifier.postList[index].tags),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text("0명 같이쓰는 중"),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 5, left: 5),
                                    child: Container(
                                      color: Colors.black26,
                                      height: 20,
                                      width: 1,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: 5, left: 5),
                                    child: Text("0명 구독중"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
