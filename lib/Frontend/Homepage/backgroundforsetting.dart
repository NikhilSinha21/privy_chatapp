
import 'package:flutter/material.dart';
import 'package:privy_chat_chat_app/Frontend/Things/color.dart';

class Backgroundforsetting extends StatelessWidget{
  const Backgroundforsetting({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: MyPainter(),
    );
  }

}

  class MyPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
  

      // Path number 1
  

      paint.shader = myGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      path = Path();
      path.lineTo(size.width, 0);
      path.cubicTo(size.width, 0, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width, size.height, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width, size.height, size.width * 0.01, size.height, size.width * 0.01, size.height);
      path.cubicTo(0, size.height, 0, size.height, 0, size.height);
      path.cubicTo(0, size.height, 0, size.height * 0.16, 0, size.height * 0.16);
      path.cubicTo(0, size.height * 0.13, size.width * 0.06, size.height * 0.1, size.width * 0.13, size.height * 0.1);
      path.cubicTo(size.width * 0.13, size.height * 0.1, size.width * 0.19, size.height * 0.1, size.width * 0.19, size.height * 0.1);
      path.cubicTo(size.width * 0.24, size.height * 0.1, size.width * 0.29, size.height * 0.08, size.width * 0.29, size.height * 0.06);
      path.cubicTo(size.width * 0.29, size.height * 0.03, size.width * 0.34, 0, size.width * 0.41, 0);
      path.cubicTo(size.width * 0.41, 0, size.width, 0, size.width, 0);
      path.cubicTo(size.width, 0, size.width, 0, size.width, 0);
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }

