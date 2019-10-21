import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mine_sweeping/common/board_config.dart';
import 'package:mine_sweeping/helper/board_builder_helper.dart';
import 'package:mine_sweeping/helper/format_helper.dart';

class TimberCounterWidget extends StatefulWidget {
  final BoardConfig config;

  TimberCounterWidget(Key key, this.config) : super(key: key);

  @override
  TimberCounterWidgetState createState() => TimberCounterWidgetState();
}

class TimberCounterWidgetState extends State<TimberCounterWidget> {
  int secondTimer = 0;

  bool isStart = false;

  @override
  Widget build(BuildContext context) {
    return getCounterWidget(secondTimer);
  }

  void onCount() {
    setState(() {
      if (isStart) secondTimer++;
    });
  }

  void start() {
    secondTimer = 0;
    isStart = true;
  }

  void pause() {
    isStart = false;
  }

  void reset() {
    isStart = false;
    setState(() {
      secondTimer = 0;
    });
  }

  int getTime() {
    return secondTimer;
  }

  Widget getCounterWidget(int count) {
    String countText = FormatHelper.to3Digits(count);
    return Container(
      child: AutoSizeText(
        countText,
        style: TextStyle(
            fontSize: widget.config.timerFontMaxSize,
            decoration: TextDecoration.none,
            color: Colors.redAccent),
      ),
      decoration: BoxDecoration(color: Colors.black),
    );
  }
}
