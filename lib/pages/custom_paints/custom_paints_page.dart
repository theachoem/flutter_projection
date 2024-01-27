import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/custom_paints/line_painter_tab.dart';

class CustomPaintsPage extends StatelessWidget {
  const CustomPaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Paint"),
      ),
      body: const LinePainterTab(),
    );
  }
}
