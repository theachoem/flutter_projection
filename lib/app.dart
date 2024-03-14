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

  final pages = {
    'Transformation': const TransformPage(),
    'Custom Paints': const CustomPaintsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Flutter Projection"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: DropdownMenu<String>(
              inputDecorationTheme:
                  const InputDecorationTheme(border: InputBorder.none),
              initialSelection: pages.keys.first,
              onSelected: (value) {
                setState(() {
                  index = pages.keys.toList().indexWhere((e) => e == value);
                });
              },
              dropdownMenuEntries: pages.entries
                  .map((e) => DropdownMenuEntry(value: e.key, label: e.key))
                  .toList(),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: pages.values.toList(),
      ),
    );
  }
}
