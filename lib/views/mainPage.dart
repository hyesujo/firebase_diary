import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/service/postNotifier.dart';
import 'package:flutter_3line_diary/service/searchdiarydelegate.dart';
import 'package:flutter_3line_diary/views/postbuiderDetail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Database _database =Database();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: (){
                search();
              },
            ),
          ),
        ],
        title: Text(
          '오늘의 일기',
          style: GoogleFonts.nanumGothic(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: showGirdPost(),
    );
  }

  void search() {
    showSearch(context: context,
        delegate: SearchPostDelegate());
  }
  Widget showGirdPost() {
    PostNotifier postNotifier =
    Provider.of<PostNotifier>(context, listen: false);
      // _database.getPost(postNotifier);
      return GridView.builder(
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               crossAxisSpacing: 3.0,
               mainAxisSpacing: 5.0,
               childAspectRatio: 0.8,
             ),
             itemCount: postNotifier.postList.length,
             itemBuilder: (context,index) {
               return GestureDetector(
                 onTap: () {
                   postNotifier.currentPost = postNotifier.postList[index];
                   Navigator.of(context).push(
                     MaterialPageRoute(
                       builder: (BuildContext context) {
                           return PostDetail();
                         }
                     ),
                   );
                 },
                 child: Card(
                   child: Container(
                     width: 100,
                     height: 130,
                     color: Colors.grey[200],
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Hero(
                           tag: postNotifier.postList[index],
                           child: Image.network(
                             postNotifier.postList[index].photoUrl,
                       width: 130,
                       height: 90,
                       fit: BoxFit.cover,
                     ),
                         ),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 8),
                           child: Container(
                             padding: EdgeInsets.only(top: 5),
                             child: Text(
                               postNotifier.postList[index].title,
                               maxLines: 1,
                               style: GoogleFonts.nanumGothic(
                                 fontSize: 14,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                           ),
                         ),
                         Flexible(
                           child: Container(
                             padding: EdgeInsets.symmetric(horizontal: 8),
                             child: Container(
                               padding: EdgeInsets.only(top: 5),
                               child: Text(
                                 postNotifier.postList[index].content,
                                 maxLines: 1,
                                 overflow: TextOverflow.fade,
                                 style: GoogleFonts.nanumGothic(
                                     fontSize: 12,
                                 fontWeight: FontWeight.w500
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             },
         );
  }
}


