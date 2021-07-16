import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class BG extends CustomPainter {
  final BuildContext context;

  BG({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final circle1 = Paint()
      ..color = kSecondaryColor
      ..style = PaintingStyle.fill;
    final circle2 = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill;
    final circle3 = Paint()
      ..color = kTextColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      const Offset(0, 0),
      157,
      circle1,
    );
    canvas.drawCircle(
      Offset(
        Localizations.localeOf(context).languageCode == 'ar'
            ? -MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      157,
      circle1,
    );
    canvas.drawCircle(
      const Offset(
        0,
        157,
      ),
      33,
      circle3,
    );
    canvas.drawCircle(
      Offset(
        Localizations.localeOf(context).languageCode == 'ar' ? -157 : 157,
        0,
      ),
      42.5,
      circle2,
    );
    canvas.drawCircle(
      Offset(
        Localizations.localeOf(context).languageCode == 'ar'
            ? -MediaQuery.of(context).size.width + 157
            : MediaQuery.of(context).size.width - 157,
        MediaQuery.of(context).size.height,
      ),
      42.5,
      circle2,
    );
    canvas.drawCircle(
      Offset(
        Localizations.localeOf(context).languageCode == 'ar'
            ? -MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 157,
      ),
      33,
      circle3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
