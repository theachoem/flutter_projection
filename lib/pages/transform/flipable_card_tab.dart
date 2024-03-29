library flipable_card_tab;

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_projection/pages/transform/local_widgets/group.dart';
import 'package:flutter_projection/pages/transform/local_widgets/inputable_slider.dart';

part 'flipable_card_tab/axis_painter.dart';
part 'flipable_card_tab/card.dart';
part 'flipable_card_tab/rectangle_painter.dart';

const Size _cardSize = Size(300, 200);

class FlipableCardTab extends StatefulWidget {
  const FlipableCardTab({
    super.key,
  });

  @override
  State<FlipableCardTab> createState() => _FlipableCardTabState();
}

class _FlipableCardTabState extends State<FlipableCardTab> {
  // 0 to 360
  late double xDegrees;
  late double yDegrees;
  late double zDegrees;

  // 0.5 to 5
  late double scale;
  late double translateX;
  late double translateY;
  late double translateZ;

  // 0 to 360
  late double xDegreesSurface;
  late double yDegreesSurface;
  late double zDegreesSurface;

  // 0.5 to 5
  late double scaleSurface;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void init3DData() {
    xDegrees = -60;
    yDegrees = 0;
    zDegrees = 45;
    scale = 1;

    translateX = 0;
    translateY = 0;
    translateZ = 0;

    // for surface
    xDegreesSurface = 0;
    yDegreesSurface = 0;
    zDegreesSurface = 0;
    scaleSurface = 1;
  }

  void initData() {
    xDegrees = 0;
    yDegrees = 0;
    zDegrees = 0;

    translateX = 0;
    translateY = 0;
    translateZ = 0;

    scale = 1;

    // for page
    xDegreesSurface = 0;
    yDegreesSurface = 0;
    zDegreesSurface = 0;
    scaleSurface = 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            supportedDevices: PointerDeviceKind.values.toSet(),
            onPanUpdate: (details) {
              setState(() {
                xDegrees += details.delta.dy;
                xDegrees %= 360;

                yDegrees -= details.delta.dx;
                yDegrees %= 360;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.surface,
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              constraints: BoxConstraints(
                minWidth: _cardSize.width,
                minHeight: _cardSize.width,
              ),
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(xDegreesSurface / 180 * math.pi)
                ..rotateY(yDegreesSurface / 180 * math.pi)
                ..rotateZ(zDegreesSurface / 180 * math.pi)
                ..scale(scaleSurface),
              child: Stack(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform:
                        transformZ(transformY(transformX(initialPerspective())))
                          ..translate(translateX, translateY, translateZ)
                          ..scale(scale),
                    child: const _Card(cardSize: _cardSize),
                  ),
                  buildAxisLines(axis: 'x', label: 'X'),
                  buildAxisLines(axis: 'y', label: 'Y'),
                  Transform(
                    transform: Matrix4.identity()
                      ..rotateX(90 / 180 * math.pi)
                      ..rotateY(90 / 180 * math.pi),
                    child: buildAxisLines(axis: 'y', label: 'Z'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: _cardSize.width - _cardSize.height),
          const Divider(height: 1),
          const SizedBox(height: 16.0),
          _buildActions(),
          Expanded(
            child: PageView(children: [
              buildCardSliders(constraints),
              buildSurfaceSliders(),
            ]),
          ),
        ],
      );
    });
  }

  Matrix4 initialPerspective() {
    // this same as below, except we can't set existing matrix:
    //
    // return Matrix4(
    //   1.0, 0.0, 0.0, 0.0, //
    //   0.0, 1.0, 0.0, 0.0, //
    //   0.0, 0.0, 1.0, 0.005, //
    //   0.0, 0.0, 0.0, 1.0,
    // );

    return Matrix4.identity()..setEntry(3, 2, 0.001);
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

  CustomPaint buildAxisLines({
    required String axis,
    required String label,
  }) {
    return CustomPaint(
      painter: _AxisPainter(axis: axis, label: label),
      size: _cardSize,
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          OutlinedButton.icon(
            icon: const Icon(Icons.history),
            label: const Text("Reset"),
            onPressed: () {
              setState(() {
                initData();
              });
            },
          ),
          const SizedBox(width: 8.0),
          OutlinedButton.icon(
            icon: const Icon(Icons.emoji_objects),
            label: const Text("3D Look"),
            onPressed: () {
              setState(() {
                init3DData();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildSurfaceSliders() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Group(children: [
          InputableSlider(
            label: 'rotated-X',
            value: xDegreesSurface,
            onChanged: (e) => setState(() => xDegreesSurface = e),
          ),
          InputableSlider(
            label: 'rotated-Y',
            value: yDegreesSurface,
            onChanged: (e) => setState(() => yDegreesSurface = e),
          ),
          InputableSlider(
            label: 'rotated-Z',
            value: zDegreesSurface,
            onChanged: (e) => setState(() => zDegreesSurface = e),
          ),
        ]),
        Group(children: [
          InputableSlider(
            label: 'scale',
            value: scaleSurface,
            onChanged: (e) => setState(() => scaleSurface = e),
            min: 0.5,
            max: 5,
          ),
        ]),
      ],
    );
  }

  Widget buildCardSliders(BoxConstraints constraints) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Group(children: [
          InputableSlider(
            label: 'rotated-X',
            value: xDegrees,
            onChanged: (e) => setState(() => xDegrees = e),
          ),
          InputableSlider(
            label: 'rotated-Y',
            value: yDegrees,
            onChanged: (e) => setState(() => yDegrees = e),
          ),
          InputableSlider(
            label: 'rotated-Z',
            value: zDegrees,
            onChanged: (e) => setState(() => zDegrees = e),
          ),
        ]),
        Group(children: [
          InputableSlider(
            label: 'translate-X',
            value: translateX,
            onChanged: (e) => setState(() => translateX = e),
          ),
          InputableSlider(
            label: 'translate-Y',
            value: translateY,
            onChanged: (e) => setState(() => translateY = e),
          ),
          InputableSlider(
            label: 'translate-Z',
            value: translateZ,
            onChanged: (e) => setState(() => translateZ = e),
            min: -constraints.maxHeight,
            max: constraints.maxHeight,
          ),
        ]),
        Group(children: [
          InputableSlider(
            label: 'scale',
            value: scale,
            onChanged: (e) => setState(() => scale = e),
            min: 0.5,
            max: 5,
          ),
        ]),
      ],
    );
  }
}
