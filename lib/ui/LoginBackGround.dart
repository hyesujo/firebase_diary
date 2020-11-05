import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {
  final bool isJoin;

  LoginBackground({
  @required this.isJoin
});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = isJoin? Colors.deepOrange: Colors.deepPurple;
    canvas.drawCircle(Offset(0,0), size.height *0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return false;
  }

}