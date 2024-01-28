library flipable_card_tab;

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

part 'flipable_card_tab/rectangle_painter.dart';
part 'flipable_card_tab/card.dart';
part 'flipable_card_tab/slider.dart';

const Size _cardSize = Size(300, 200);

class FlipableCardTab extends StatefulWidget {
  const FlipableCardTab({
    super.key,
  });

  @override
  State<FlipableCardTab> createState() => _FlipableCardTabState();
}

class _FlipableCardTabState extends State<FlipableCardTab> {
  bool front = true;

  // 0 to 360
  late double xDegrees;
  late double yDegrees;
  late double zDegrees;

  // 0.5 to 5
  late double scale;
  late double translateX;
  late double translateY;
  late double translateZ;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    xDegrees = -60;
    yDegrees = 0;
    zDegrees = 45;
    scale = 1;

    translateX = 0;
    translateY = 0;
    translateZ = 0;
  }

  void straightenData() {
    xDegrees = 0;
    yDegrees = 0;
    zDegrees = 0;

    translateX = 0;
    translateY = 0;
    translateZ = 0;

    scale = 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              supportedDevices: PointerDeviceKind.values.toSet(),
              onVerticalDragUpdate: (details) {
                setState(() {
                  xDegrees += details.delta.dy;
                  xDegrees %= 360;
                  front = xDegrees <= 90 || xDegrees >= 270;
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  yDegrees -= details.delta.dx;
                  yDegrees %= 360;
                });
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: _cardSize.height,
                  minWidth: _cardSize.width,
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: transformZ(
                    transformY(
                      transformX(
                        perspective(Matrix4.identity()..scale(scale)),
                      ),
                    ),
                  )..translate(translateX, translateY, translateZ),
                  child: const _Card(cardSize: _cardSize),
                ),
              ),
            ),
            SizedBox(height: _cardSize.width - _cardSize.height),
            ...buildSliders(constraints),
            const SizedBox(height: 32.0),
            _buildActions()
          ],
        ),
      );
    });
  }

  Matrix4 perspective([Matrix4? existing]) {
    existing ??= Matrix4.identity();

    // this same as below, except we can't set existing matrix:
    //
    // return Matrix4(
    //   1.0, 0.0, 0.0, 0.0, //
    //   0.0, 1.0, 0.0, 0.0, //
    //   0.0, 0.0, 1.0, 0.001, //
    //   0.0, 0.0, 0.0, 1.0,
    // );

    return existing..setEntry(3, 2, 0.001);
  }

  Matrix4 transformX([Matrix4? existing]) {
    existing ??= Matrix4.identity();
    double angle = xDegrees / 180 * math.pi;

    // this same as below, except we can't add existing matrix:
    //
    // return Matrix4(
    //   1.0, 0.0, 0.0, 0.0, //
    //   0.0, math.cos(angle), -math.sin(angle), 0.0, //
    //   0.0, math.sin(angle), math.cos(angle), 0.0, //
    //   0.0, 0.0, 0.0, 1.0,
    // );

    return existing..rotateX(angle);
  }

  Matrix4 transformY([Matrix4? existing]) {
    existing ??= Matrix4.identity();
    double angle = yDegrees / 180 * math.pi;

    // this same as below, except we can't add existing matrix:
    //
    // return Matrix4(
    //   math.cos(angle), 0.0, -math.sin(angle), 0.0, //
    //   0.0, 1.0, 0.0, 0.0, //
    //   math.sin(angle), 0.0, math.cos(angle), 0.0, //
    //   0.0, 0.0, 0.0, 1.0,
    // );

    return existing..rotateY(angle);
  }

  Matrix4 transformZ([Matrix4? existing]) {
    existing ??= Matrix4.identity();
    double angle = zDegrees / 180 * math.pi;

    // this same as below, except we can't add existing matrix:
    //
    // return Matrix4(
    //   math.cos(angle), -math.sin(angle), 0.0, 0.0, //
    //   math.sin(angle), math.cos(angle), 0.0, 0.0, //
    //   0.0, 0.0, 1.0, 0.0, //
    //   0.0, 0.0, 0.0, 1.0,
    // );

    return existing..rotateZ(angle);
  }

  List<Widget> buildSliders(BoxConstraints constraints) {
    return [
      _Slider(
        label: 'rotated-X',
        value: xDegrees,
        onChanged: (e) => setState(() => xDegrees = e),
      ),
      _Slider(
        label: 'rotated-Y',
        value: yDegrees,
        onChanged: (e) => setState(() => yDegrees = e),
      ),
      _Slider(
        label: 'rotated-Z',
        value: zDegrees,
        onChanged: (e) => setState(() => zDegrees = e),
      ),
      _Slider(
        label: 'translate-X',
        value: translateX,
        onChanged: (e) => setState(() => translateX = e),
      ),
      _Slider(
        label: 'translate-Y',
        value: translateY,
        onChanged: (e) => setState(() => translateY = e),
      ),
      _Slider(
        label: 'translate-Z',
        value: translateZ,
        onChanged: (e) => setState(() => translateZ = e),
        min: -constraints.maxHeight,
        max: constraints.maxHeight,
      ),
      _Slider(
        label: 'scale',
        value: scale,
        onChanged: (e) => setState(() => scale = e),
        min: 0.5,
        max: 5,
      ),
    ];
  }

  Widget _buildActions() {
    return Row(
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.line_axis),
          label: const Text("Stright"),
          onPressed: () {
            setState(() {
              straightenData();
            });
          },
        ),
        const SizedBox(width: 8.0),
        OutlinedButton.icon(
          icon: const Icon(Icons.history),
          label: const Text("Reset"),
          onPressed: () {
            setState(() {
              initData();
            });
          },
        ),
      ],
    );
  }
}
