import 'package:flutter/material.dart';

class TrianglePainterTab extends StatelessWidget {
  const TrianglePainterTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double x = size.width / 2;
    double y = size.height / 2;
    double h = 120;

    double ax = x + h;
    double ay = y + h;
    double bx = x - h;
    double by = y + h;
    double cx = x;
    double cy = y;

    Path path = Path()
      ..moveTo(x, y)
      ..lineTo(ax, ay)
      ..lineTo(bx, by)
      ..lineTo(cx, cy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
