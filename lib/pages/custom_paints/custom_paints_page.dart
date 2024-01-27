import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/custom_paints/circle_painter_tab.dart';
import 'package:flutter_projection/pages/custom_paints/line_painter_tab.dart';

class CustomPaintsPage extends StatelessWidget {
  const CustomPaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const LinePainterTab(),
      const CirclePainterTab(),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Custom Paint"),
          bottom: TabBar(
            tabs: tabs.map((e) {
              return Tab(text: e.runtimeType.toString());
            }).toList(),
          ),
        ),
        body: TabBarView(children: tabs),
      ),
    );
  }
}
