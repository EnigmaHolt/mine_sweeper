import 'package:flutter/material.dart';
import 'package:mine_sweeping/pages/page/home_page.dart';
import 'package:mine_sweeping/pages/widget/main_game_widget.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper Online',
      checkerboardOffscreenLayers: true,
      checkerboardRasterCacheImages: true,
      home: MainPage(),
    );
  }
}
