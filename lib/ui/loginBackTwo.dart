import 'package:flutter/material.dart';

class LoginBackTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange;
    canvas.drawCircle(Offset(size.width *0.9,0), size.height *0.6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}