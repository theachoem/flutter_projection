part of flipable_card_tab;

class _Card extends StatelessWidget {
  const _Card({
    required this.cardSize,
  });

  final Size cardSize;

  double get cardHeight => _cardSize.height;
  double get cardWidth => _cardSize.width;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: CustomPaint(
        painter: _RectanglesPainter(),
        size: cardSize,
        child: Container(
          width: cardWidth,
          height: cardHeight,
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: [
              buildShadow(),
              Transform(
                transform: Matrix4.identity()
                  ..rotateX(45 / 180 * math.pi)
                  ..translate(0.0, -16.0),
                child: const Text(
                  "THIS IS FRONT",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShadow() {
    return Transform(
      transform: Matrix4.identity()
        ..rotateX(0 / 180 * math.pi)
        ..translate(0.0, -33.0)
        ..scale(1.0, 2, 1.0),
      child: const Text(
        "THIS IS FRONT",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black26,
        ),
      ),
    );
  }
}
