part of flipable_card_tab;

class _RectanglesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 3; j++) {
        Paint paint = Paint()
          ..color = Colors.primaries[(i + j) % Colors.primaries.length]
          ..strokeWidth = 1;

        Offset pointA = Offset(i * size.width / 4, j * size.height / 3);
        Offset pointB =
            Offset(pointA.dx + size.width / 4, pointA.dy + size.height / 3);

        canvas.drawRect(
          Rect.fromPoints(pointA, pointB),
          paint,
        );

        TextPainter textPainter = TextPainter(
          textAlign: TextAlign.justify,
          textDirection: TextDirection.ltr,
          text: TextSpan(
            style: const TextStyle(fontSize: 8),
            children: [
              TextSpan(text: 'A: ${displayOffset(pointA)}\n'),
              TextSpan(text: 'B: ${displayOffset(pointB)}\n'),
            ],
          ),
        )..layout(maxWidth: size.width / 4);

        textPainter.paint(
          canvas,
          Offset(i * size.width / 4, j * size.height / 3),
        );
      }
    }
  }

  String displayOffset(Offset offset) {
    return [
      offset.dx.toStringAsFixed(2),
      offset.dy.toStringAsFixed(2),
    ].join(":");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
