

import 'package:flutter/material.dart';
import 'package:Privy/Frontend/Things/color.dart';

class Background extends StatelessWidget{
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(
         size: size, // same size as your Container
         painter: MyPainter(),
                 
      ),
    );
  }

}

// CustomPainter for concave bottom-right corner
  class MyPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
      Paint paint = Paint();
      Path path = Path();
  

      // Path number 1
  

      paint.shader = myGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
      path = Path();
      path.lineTo(size.width * 0.59, 0);
      path.cubicTo(size.width * 0.66, 0, size.width * 0.71, size.height * 0.03, size.width * 0.71, size.height * 0.06);
      path.cubicTo(size.width * 0.71, size.height * 0.08, size.width * 0.76, size.height * 0.1, size.width * 0.81, size.height * 0.1);
      path.cubicTo(size.width * 0.81, size.height * 0.1, size.width * 0.87, size.height * 0.1, size.width * 0.87, size.height * 0.1);
      path.cubicTo(size.width * 0.94, size.height * 0.1, size.width, size.height * 0.13, size.width, size.height * 0.16);
      path.cubicTo(size.width, size.height * 0.16, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width, size.height, size.width, size.height, size.width, size.height);
      path.cubicTo(size.width, size.height, size.width * 0.01, size.height, size.width * 0.01, size.height);
      path.cubicTo(0, size.height, 0, size.height, 0, size.height);
      path.cubicTo(0, size.height, 0, 0, 0, 0);
      path.cubicTo(0, 0, 0, 0, size.width * 0.01, 0);
      path.cubicTo(size.width * 0.01, 0, size.width * 0.59, 0, size.width * 0.59, 0);
      path.cubicTo(size.width * 0.59, 0, size.width * 0.59, 0, size.width * 0.59, 0);
      canvas.drawPath(path, paint);
    }
    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return true;
    }
  }
  
