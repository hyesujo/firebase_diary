import 'package:flutter/material.dart';


class SearchPostDelegate extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [Text('build action')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Text('Leading');
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return Text('sugestion');
  }

}