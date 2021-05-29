import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class BG extends CustomPainter {
  final context;

  BG({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    var circle1 = Paint()
      ..color = KSecondaryColor
      ..style = PaintingStyle.fill;
    var circle2 = Paint()
      ..color = KPrimaryColor
      ..style = PaintingStyle.fill;
    var circle3 = Paint()
      ..color = KTextColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(0, 0),
      157,
      circle1,
    );
    canvas.drawCircle(
      Offset(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      157,
      circle1,
    );
    canvas.drawCircle(
      Offset(
        0,
        160,
      ),
      42.5,
      circle2,
    );
    canvas.drawCircle(
      Offset(
        160,
        0,
      ),
      33,
      circle3,
    );
    canvas.drawCircle(
      Offset(
        MediaQuery.of(context).size.width-165,
        MediaQuery.of(context).size.height - 20,
      ),
      33,
      circle3,
    );
    canvas.drawCircle(
      Offset(
        160,
        0,
      ),
      33,
      circle3,
    );
    canvas.drawCircle(
      Offset(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height - 160),
      42.5,
      circle2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
