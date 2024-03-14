import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show Vector3, Quaternion;
import 'dart:math' as math;

class QuaternionTab extends StatefulWidget {
  const QuaternionTab({super.key});

  @override
  State<QuaternionTab> createState() => _QuaternionTabState();
}

class _QuaternionTabState extends State<QuaternionTab> {
  double scale = 1.0;
  double xDegrees = 45.0;
  double yDegrees = 45.0;
  double zDegrees = 45.0;

  // sphere datas
  double sphereRadius = 400;
  double numberOfSides = 9 * 4;
  double degrees = 10;

  late double radians;
  late double cutHeight;

  @override
  void initState() {
    radians = degrees * (math.pi / 180);
    cutHeight = sphereRadius * math.sin(radians);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(scale)
            ..rotateX(xDegrees / 180 * math.pi)
            ..rotateY(yDegrees / 180 * math.pi)
            ..rotateZ(zDegrees / 180 * math.pi),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ...buildCuts(),
              const Divider(),
              const VerticalDivider(),
            ],
          ),
        ),
        buildSliders(),
      ],
    );
  }

  List<Widget> buildCuts() {
    return [
      // for (int i = 1; i < 10; i++)
      //   for (int j = 0; j < numberOfSides; j++)
      //     buildCut(
      //       axis: Vector3(1, 0, 0),
      //       i: i,
      //       j: j,
      //       initialPoint: Vector3(
      //         -i * cutHeight,
      //         0.0,
      //         i * cutHeight / 2 - sphereRadius,
      //       ),
      //     ),
      // for (int i = 1; i < 10; i++)
      //   for (int j = 0; j < numberOfSides; j++)
      //     buildCut(
      //       axis: Vector3(1, 0, 0),
      //       i: i,
      //       j: j,
      //       initialPoint: Vector3(
      //         i * cutHeight,
      //         0.0,
      //         i * cutHeight / 2 - sphereRadius,
      //       ),
      //     ),

      for (int j = 0; j < numberOfSides; j++)
        buildCut(
          axis: Vector3(1.0, 0.0, 0.0),
          i: 0,
          j: j,
          initialPoint: Vector3(
            0.0,
            0.0,
            sphereRadius,
          ),
        ),

      for (int j = 0; j < numberOfSides; j++)
        buildCut(
          axis: Vector3(0.0, 1.0, 0.0),
          i: 0,
          j: j,
          initialPoint: Vector3(
            0.0,
            0.0,
            sphereRadius,
          ),
        ),
    ];
  }

  Widget buildCut({
    required Vector3 axis,
    required int i,
    required int j,
    required Vector3 initialPoint,
  }) {
    double angle = j * degrees * (math.pi / 180);
    Quaternion q = Quaternion.axisAngle(axis, angle);
    Vector3 point = q.rotate(initialPoint);

    return Container(
      transform: Matrix4.identity()
        // ..setEntry(3, 2, 0.001)
        // ..rotateX(degreeX / 180 * math.pi)
        // ..rotateY(degreeY / 180 * math.pi)
        ..translate(point.x, point.y, point.z),
      width: cutHeight,
      height: cutHeight,
      color: Colors.primaries[(i + j) % Colors.primaries.length],
      padding: const EdgeInsets.all(2.0),
      child: Text(
        'index\n$cutHeight',
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget buildSliders() {
    return Column(
      children: [
        Slider.adaptive(
          value: scale,
          min: 0.1,
          max: 5.0,
          label: scale.toString(),
          onChanged: (value) {
            setState(() {
              scale = value;
            });
          },
        ),
        Slider.adaptive(
          value: xDegrees,
          min: -360,
          max: 360,
          label: xDegrees.toString(),
          onChanged: (value) {
            setState(() {
              xDegrees = value;
            });
          },
        ),
        Slider.adaptive(
          value: yDegrees,
          min: -360,
          max: 360,
          label: yDegrees.toString(),
          onChanged: (value) {
            setState(() {
              yDegrees = value;
            });
          },
        ),
        Slider.adaptive(
          value: zDegrees,
          min: -360,
          max: 360,
          label: zDegrees.toString(),
          onChanged: (value) {
            setState(() {
              zDegrees = value;
            });
          },
        ),
      ],
    );
  }
}
