// Widget buildGridView({List post}) {
//   return GridView.count(
//     childAspectRatio: 0.8,
//     crossAxisCount: 3,
//     children: buildItem(post),
//   );
// }
//
// List<Widget> buildItem(List<Post> post) {
//   List<Widget> widgets = [];
//
//   for (int i = 0; i < post.length; i++) {
//     Post posts = post[i];
//
//     Widget addWidget = GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//             MaterialPageRoute(
//           builder: (BuildContext context) =>
//               PostDetail(post: posts,index: i),
//         ),
//         );
//       },
//       child: Card(
//         child: Container(
//           width: 100,
//           height: 100,
//           color: Colors.black12,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Hero(
//                 tag: "$i",
//                 child: Image.network(
//                   posts.photoUrl,
//                   width: 130,
//                   height: 90,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Text(
//                   posts.title,
//                   maxLines: 1,
//                   style: GoogleFonts.nanumGothic(
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     posts.content,
//                     overflow: TextOverflow.fade,
//                     style: GoogleFonts.nanumGothic(fontSize: 12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     widgets.add(addWidget);
//   }
//   return widgets;
// }
