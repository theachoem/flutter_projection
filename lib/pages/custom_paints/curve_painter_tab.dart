import 'package:flutter/material.dart';

class CurvePainterTab extends StatelessWidget {
  const CurvePainterTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvePainter(),
      size: const Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    double h = 200;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, h)
      ..quadraticBezierTo(size.width / 2, h + 160, size.width, h)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
