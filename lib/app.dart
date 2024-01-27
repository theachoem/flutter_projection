import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/custom_paints/custom_paints_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const CustomPaintsPage(),
    );
  }
}
