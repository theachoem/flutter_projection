part of flipable_card_tab;

class _AxisPainter extends CustomPainter {
  final String axis;
  final String label;

  _AxisPainter({
    required this.axis,
    required this.label,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;

    if (axis == 'x') {
      double seperatorX = 0;
      while (seperatorX <= _cardSize.width) {
        canvas.drawLine(
          Offset(0.0, seperatorX),
          Offset(_cardSize.width + 16.0, seperatorX),
          paint,
        );
        seperatorX += 50;
      }

      paintText(
        maxWidth: size.width / 4,
        canvas: canvas,
        offset: Offset(_cardSize.width, -16.0),
        text: TextSpan(style: const TextStyle(fontSize: 16), text: label),
      );
    } else if (axis == 'y') {
      double seperatorY = 0;
      while (seperatorY <= _cardSize.width) {
        canvas.drawLine(
          Offset(seperatorY, 0.0),
          Offset(seperatorY, _cardSize.width + 16.0),
          paint,
        );
        seperatorY += 50;
      }

      paintText(
        maxWidth: size.width / 4,
        canvas: canvas,
        offset: Offset(-16.0, _cardSize.width),
        text: TextSpan(style: const TextStyle(fontSize: 16), text: label),
      );
    }
  }

  void paintText({
    required double maxWidth,
    required Canvas canvas,
    required TextSpan text,
    required Offset offset,
  }) {
    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
      text: text,
    )..layout(maxWidth: maxWidth);

    textPainter.paint(
      canvas,
      offset,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
