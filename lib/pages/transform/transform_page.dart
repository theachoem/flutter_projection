import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/transform/flipable_card_tab.dart';
import 'package:flutter_projection/pages/transform/quaternion_tab.dart';

class TransformPage extends StatelessWidget {
  const TransformPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Quaternion': const QuaternionTab(),
      'FlipableCard': const FlipableCardTab(),
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: TabBar(
          tabs: tabs.keys.map((key) {
            return Tab(text: key);
          }).toList(),
        ),
        body: TabBarView(children: tabs.values.toList()),
      ),
    );
  }
}
