import 'package:flutter/material.dart';
import 'package:flutter_projection/pages/custom_paints/custom_paints_page.dart';
import 'package:flutter_projection/pages/transform/transform_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = [
    const CustomPaintsPage(),
    const TransformPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownMenu<String>(
          onSelected: (value) {
            setState(() {
              index = pages.indexWhere((e) {
                return e.runtimeType.toString() == value;
              });
            });
          },
          dropdownMenuEntries: pages.map(
            (e) {
              return DropdownMenuEntry(
                value: e.runtimeType.toString(),
                label: e.runtimeType.toString(),
              );
            },
          ).toList(),
        ),
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
    );
  }
}
