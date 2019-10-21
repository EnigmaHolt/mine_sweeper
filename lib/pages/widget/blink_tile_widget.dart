import 'package:flutter/material.dart';
import 'package:mine_sweeping/common/board_config.dart';
import 'package:mine_sweeping/constant/colors.dart';

class BlinkTileWidget extends StatefulWidget {
  final BoardConfig boardConfig;

  BlinkTileWidget(this.boardConfig);

  @override
  _BlinkTileWidgetState createState() => _BlinkTileWidgetState();
}

class _BlinkTileWidgetState extends State<BlinkTileWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        width: widget.boardConfig.tileSize,
        height: widget.boardConfig.tileSize,
        decoration: BoxDecoration(
            color: LocalColor.game_board_bg,
            border: Border(
                left: BorderSide(width: 1, color: Colors.white),
                top: BorderSide(width: 1, color: Colors.white),
                right: BorderSide(
                    width: 1, color: LocalColor.closed_tile_dark_border),
                bottom: BorderSide(
                    width: 1, color: LocalColor.closed_tile_dark_border))),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
