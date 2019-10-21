import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeping/blocs/game_board_bloc.dart';
import 'package:mine_sweeping/common/board_config.dart';
import 'package:mine_sweeping/constant/colors.dart';
import 'package:mine_sweeping/data/enum_game_status.dart';
import 'package:mine_sweeping/data/enum_mark_status.dart';
import 'package:mine_sweeping/data/enum_user_action.dart';
import 'package:mine_sweeping/data/event/game_board_event.dart';
import 'package:mine_sweeping/data/state/game_board_state.dart';
import 'package:mine_sweeping/helper/board_builder_helper.dart';
import 'package:mine_sweeping/helper/format_helper.dart';
import 'package:mine_sweeping/models/base/base_board_tile.dart';
import 'package:mine_sweeping/models/bomb_board_tile.dart';
import 'package:mine_sweeping/models/safe_board_tile.dart';
import 'package:mine_sweeping/pages/widget/blink_tile_widget.dart';
import 'package:mine_sweeping/pages/widget/time_counter_widget.dart';

class MainGameWidget extends StatefulWidget {
  final GameBoardBloc bloc;

  MainGameWidget(this.bloc);

  @override
  _MainGameWidgetState createState() => _MainGameWidgetState();
}

class _MainGameWidgetState extends State<MainGameWidget> {
  GameBoardBloc bloc;

  GlobalKey<TimberCounterWidgetState> timeCountKey = GlobalKey();
  TextEditingController _playerName = TextEditingController();

  Timer _countTimer;

  int checkX;
  int checkY;
  BoardConfig boardConfig;

  @override
  void initState() {
    bloc = widget.bloc;
    boardConfig = BoardConfig(1);
    _countTimer = Timer.periodic(Duration(seconds: 1), (time) {
      timeCountKey.currentState?.onCount();
    });
    bloc.add(NewGameEvent());

    bloc.listen((state){
      if(state is GameWinState){

        ///if user win, ask user to upload their record.
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Upload your record'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _playerName,
                      decoration:
                      InputDecoration(hintText: "Input your name"),
                    ),
                    SizedBox(height: 10,),
                    Text(
                        "You time is ${timeCountKey.currentState.secondTimer} s")
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text('CONFIRM'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    _countTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBoardBloc, GameBoardState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is GameOverState) {
          /// game failed
          timeCountKey.currentState?.pause();
        }

        if (state is GameWinState) {

          /// game win
          timeCountKey.currentState?.pause();


        }

        if (state is TimingStartState) {
          ///start counting time
          timeCountKey.currentState?.start();
        }

        if (state is GameInitState) {
          ///new game
          timeCountKey.currentState?.reset();
        }

        if (state is CheckTileAroundState) {
          checkX = state.x;
          checkY = state.y;
        } else {
          checkX = null;
          checkY = null;
        }

        if (state is BoardDisplayChangeState) {
          if (state.scale != boardConfig.scale) {
            boardConfig = BoardConfig(state.scale);
          }
        }

        return Container(
          color: LocalColor.game_board_bg,
          child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          width: boardConfig.boardEdgeWidth,
                          color: Colors.white),
                      top: BorderSide(
                          width: boardConfig.boardEdgeWidth,
                          color: Colors.white),
                      right: BorderSide(
                          width: boardConfig.boardEdgeWidth,
                          color: LocalColor.closed_tile_dark_border),
                      bottom: BorderSide(
                          width: boardConfig.boardEdgeWidth,
                          color: LocalColor.closed_tile_dark_border))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[buildBoardBar(), buildBoard()],
              )),
        );
      },
    );
  }

  Widget buildBoardBar() {
    return Container(
      margin: EdgeInsets.only(
        top: boardConfig.boardEdgeWidth,
      ),
      height: boardConfig.controlBarHeight,
      width: bloc.mineBoard.boardWidth * boardConfig.tileSize.floorToDouble(),
      decoration: BoxDecoration(
          color: LocalColor.game_board_bg,
          border: Border(
              right: BorderSide(width: 1, color: Colors.white),
              bottom: BorderSide(width: 1, color: Colors.white),
              left: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border),
              top: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border))),
      child: Container(
        margin: EdgeInsets.only(
          left: boardConfig.boardEdgeWidth,
          right: boardConfig.boardEdgeWidth,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: getCounterWidget(bloc.markedBombNumber)),
            Container(
              width: boardConfig.resetButtonSize,
              height: boardConfig.resetButtonSize,
              alignment: Alignment.center,
              child: GestureDetector(
                child: bloc.gameStatus == GameStatus.FAILED
                    ? Icon(
                        Icons.mood_bad,
                        color: Colors.deepOrangeAccent,
                        size: boardConfig.resetButtonSize,
                      )
                    : bloc.gameStatus == GameStatus.WIN
                        ? Icon(
                            Icons.wb_sunny,
                            size: boardConfig.resetButtonSize,
                            color: Colors.yellowAccent,
                          )
                        : Icon(
                            Icons.tag_faces,
                            color: Colors.blueAccent,
                            size: boardConfig.resetButtonSize,
                          ),
                onTapUp: (details) {
                  bloc.add(NewGameEvent());
                },
              ),
            ),
            Flexible(
              child: TimberCounterWidget(timeCountKey, boardConfig),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoard() {
    return Container(
      margin: EdgeInsets.all(
        boardConfig.boardEdgeWidth,
      ),
      width: bloc.mineBoard.boardWidth * boardConfig.tileSize.floorToDouble(),
      height: bloc.mineBoard.boardHeight * boardConfig.tileSize.floorToDouble(),
      decoration: BoxDecoration(
          color: LocalColor.game_board_bg,
          border: Border(
              right: BorderSide(width: 1, color: Colors.white),
              bottom: BorderSide(width: 1, color: Colors.white),
              left: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border),
              top: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border))),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: bloc.mineBoard.boardWidth),
        itemBuilder: (context, position) {
          int x = (position / bloc.mineBoard.boardWidth).floor();
          int y = (position % bloc.mineBoard.boardWidth);
          BaseBoardTile tile = bloc.mineBoard.tiles[x][y];

          return GestureDetector(
            child: getTileWidget(x, y, tile),
            onTap: () {
              bloc.add(UserBoardActionEvent(UserAction.LEFT_CLICK, x, y));
            },
            onLongPress: () {
              bloc.add(UserBoardActionEvent(UserAction.LONG_CLICK, x, y));
            },
          );
        },
        itemCount: bloc.mineBoard.totalTiles,
      ),
    );
  }

  Widget getTileWidget(int x, int y, BaseBoardTile tile) {
    if (!tile.isOpen && tile.markStatus == TileMarkStatus.NONE) {
      if (checkX != null &&
          checkY != null &&
          (x == checkX - 1 || x == checkX + 1 || x == checkX) &&
          (y == checkY - 1 || y == checkY + 1 || y == checkY)) {
        ///user is checking adjacent squares
        return BlinkTileWidget(boardConfig);
      } else {
        return getClosetTile();
      }
    } else if (!tile.isOpen && tile.markStatus == TileMarkStatus.FLAG) {
      /// the tile is marked by user
      return getFlagTile();
    } else if (!tile.isOpen && tile.markStatus == TileMarkStatus.NOT_SURE) {
      /// the tile is marked by user
      return getNotSureTile();
    } else if (tile.markStatus == TileMarkStatus.FLAG &&
        tile is SafeBoardTile &&
        tile.isOpen) {
      /// the tile is marked by user but it's wrong
      return getWrongFlagTile();
    }

    if (tile is BombBoardTile) {
      return tile.markStatus == TileMarkStatus.FLAG
          ? getFlagTile()
          : tile.isTriggered ? getBombTriggeredTile() : getBombTile();
    } else if (tile is SafeBoardTile) {
      if (tile.aroundBombNumber == 0) {
        return getEmptyOpenTile();
      } else {
        return getSafeNumberTile(tile.aroundBombNumber);
      }
    } else {
      return Text("r");
    }
  }

  ////tile builder helper
  Widget getClosetTile() {
    return Container(
      width: boardConfig.tileSize,
      height: boardConfig.tileSize,
      decoration: BoxDecoration(
          color: LocalColor.game_board_bg,
          border: Border(
              left: BorderSide(width: 1, color: Colors.white),
              top: BorderSide(width: 1, color: Colors.white),
              right: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border),
              bottom: BorderSide(
                  width: 1, color: LocalColor.closed_tile_dark_border))),
    );
  }

  Widget getFlagTile() {
    return Container(
      child: Stack(
        children: <Widget>[
          getClosetTile(),
          Center(
            child: Icon(
              Icons.flag,
              size: boardConfig.tileSize,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget getNotSureTile() {
    return Container(
      child: Stack(
        children: <Widget>[
          getClosetTile(),
          Center(
            child: AutoSizeText("?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget getBombTriggeredTile() {
    return Container(
      child: Stack(
        children: <Widget>[
          getBombTriggeredEmptyOpenTile(),
          Center(
              child: Icon(
            Icons.flash_on,
            color: Colors.yellowAccent,
            size: boardConfig.tileSize,
          )),
        ],
      ),
    );
  }

  Widget getBombTile() {
    return Container(
      child: Stack(
        children: <Widget>[
          getEmptyOpenTile(),
          Center(
            child: Icon(
              Icons.flash_on,
              color: Colors.yellowAccent,
              size: boardConfig.tileSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget getSafeNumberTile(int number) {
    return Container(
      child: Stack(
        children: <Widget>[
          getEmptyOpenTile(),
          Center(
            child: AutoSizeText(number.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color:
                        BoardBuilderHelper.getColorByAroundBombNumber(number))),
          ),
        ],
      ),
    );
  }

  Widget getEmptyOpenTile() {
    return Container(
      width: boardConfig.tileSize,
      height: boardConfig.tileSize,
      decoration: BoxDecoration(
          color: LocalColor.game_board_bg,
          border: Border.all(
              width: 0.5, color: LocalColor.closed_tile_dark_border)),
    );
  }

  Widget getBombTriggeredEmptyOpenTile() {
    return Container(
      width: boardConfig.tileSize,
      height: boardConfig.tileSize,
      decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(
              width: 0.5, color: LocalColor.closed_tile_dark_border)),
    );
  }

  Widget getWrongFlagTile() {
    return Container(
      child: Stack(
        children: <Widget>[
          getEmptyOpenTile(),
          Center(
              child: Icon(
            Icons.flash_on,
            color: Colors.yellowAccent,
            size: boardConfig.tileSize,
          )),
          Icon(
            Icons.close,
            color: Colors.redAccent,
            size: boardConfig.tileSize,
          )
        ],
      ),
    );
  }

  Widget getCounterWidget(int count) {
    String countText = FormatHelper.to3Digits(count);
    return Container(
      child: AutoSizeText(
        countText,
        style: TextStyle(
            fontSize: boardConfig.timerFontMaxSize,
            decoration: TextDecoration.none,
            color: Colors.redAccent),
      ),
      decoration: BoxDecoration(color: Colors.black),
    );
  }
}
