import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/custom_paints/circle_painter_tab.dart';
import 'package:flutter_projection/pages/custom_paints/curve_painter_tab.dart';
import 'package:flutter_projection/pages/custom_paints/line_painter_tab.dart';
import 'package:flutter_projection/pages/custom_paints/rectangle_painter_tab.dart';
import 'package:flutter_projection/pages/custom_paints/triangle_painter_tab.dart';

class CustomPaintsPage extends StatelessWidget {
  const CustomPaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const LinePainterTab(),
      const CirclePainterTab(),
      const RectanglePainterTab(),
      const TrianglePainterTab(),
      const CurvePainterTab(),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: TabBar(
          tabs: tabs.map((e) {
            return Tab(text: e.runtimeType.toString());
          }).toList(),
        ),
        body: TabBarView(children: tabs),
      ),
    );
  }
}
