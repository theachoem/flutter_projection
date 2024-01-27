import 'package:flutter/material.dart';

class RectanglePainterTab extends StatelessWidget {
  const RectanglePainterTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RectanglePainter(),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}

class _RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, (size.height - size.width) / 2),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.purple,
    );

    canvas.drawRect(
      Rect.fromCircle(center: center, radius: size.width / 2),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.blue,
    );

    canvas.drawRect(
      Rect.fromPoints(
        Offset(0.0, size.height / 2 + size.width / 2),
        Offset(size.width, size.height),
      ),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.green,
    );

    canvas.drawRect(
      Rect.fromCenter(
        center: center,
        width: size.width - 16.0 * 2,
        height: size.width - 16.0 * 2,
      ),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.red
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke,
    );

    canvas.drawRect(
      Rect.fromLTRB(
        16.0,
        size.height - (size.height - size.width) / 2 + 16.0,
        size.width - 16.0,
        size.height - 16.0,
      ),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.yellow
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke,
    );

    canvas.drawRRect(
      RRect.fromRectXY(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width - 16 * 2,
          height: size.width - 16 * 2,
        ),
        size.width / 2,
        size.width / 2,
      ),
      Paint()
        ..strokeWidth = 2.0
        ..color = Colors.yellow
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
