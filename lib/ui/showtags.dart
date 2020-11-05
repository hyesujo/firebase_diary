

import 'package:flutter/material.dart';

class ShowTags extends StatelessWidget {

  List<String> tags;

  ShowTags(this.tags);

  Widget showTag(List<String> tags){
    String text ='';

    for(var i=0; i < tags.length; i++){
      text += "#${tags[i]}";
    }
    return Text(
      text,
      style: TextStyle(
          color: Colors.blue,
        fontSize: 13
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return showTag(tags);
  }
}
