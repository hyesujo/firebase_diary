import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_3line_diary/model/post.dart';
import 'package:flutter_3line_diary/service/database.dart';
import 'package:flutter_3line_diary/ui/showtags.dart';


class SearchPostDelegate extends SearchDelegate{

 @override
  TextStyle get searchFieldStyle => TextStyle(
     fontSize: 14,
     color: Colors.blueAccent
 );

 @override
  String get searchFieldLabel =>  '누구의 삶이 궁금한가요?';

 Database db = Database();

  @override

  List<Widget> buildActions(BuildContext context) {
    return [
     IconButton(
     icon: Icon(Icons.search),
     onPressed: (){
     },
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
     icon: Icon(Icons.arrow_back_ios),
     onPressed: (){
      Navigator.of(context).pop();
     },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   print(query);

   String q = query;



   query = '';
    return FutureBuilder(
     future: db.listPostKeyword(q),
     builder: (context, snapshot) {
      if (snapshot.hasData) {
      List<Post> posts = snapshot.data;

      print(posts.length);

      return ListView.builder(
       itemCount: posts.length,
          itemBuilder: (context,index) {
           Post post = posts[index];
          return Container(
           height: 100,
            child: ListTile(
             leading: Image.network(
              post.photoUrl,
                fit: BoxFit.cover,
              width: 100,
              height: 100,
             ),
           title: Column(
            children: [
             Text(post.title),
             SizedBox(
              height: 5,
             ),
             Text(post.content),
             ShowTags(post.tags),
            ],
           ),
            ),
          );
          }
          );
      }
      if (snapshot.hasError) {
       return Text('${snapshot.error}');
      }
      return Container();
     },
    );
  }

  @override
   Widget buildSuggestions(BuildContext context) {
   List<String> lifetags = [
    '10대',
    '20대',
    '30대',
    '40대',
    '50대',
    '60대',
    '가수',
    '경찰',
   ];
   return Container(
    height: 600,
    child: ListView.builder(
     itemCount: lifetags.length,
        itemBuilder: (context,index) {
      String tag = lifetags[index];
      return GestureDetector(
       onTap: (){
        query = tag;
        showResults(context);
       },
        child: Container(
         height: 60,
         margin: EdgeInsets.only(left: 18),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children:[
              Text('#$tag'),
              Divider(thickness: 0.2,
              color: Colors.black45
              ),
             ]
         ),
        ),
      );
        }
    ),
   );
  }

}