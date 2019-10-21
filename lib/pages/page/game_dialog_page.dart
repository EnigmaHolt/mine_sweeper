import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mine_sweeping/blocs/game_board_bloc.dart';
import 'package:mine_sweeping/common/board_config.dart';
import 'package:mine_sweeping/common/board_static_setting.dart';
import 'package:mine_sweeping/constant/colors.dart';
import 'package:mine_sweeping/constant/strings.dart';
import 'package:mine_sweeping/data/state/game_board_state.dart';
import 'package:mine_sweeping/helper/format_helper.dart';
import 'package:mine_sweeping/manager/game_global_manager.dart';
import 'package:mine_sweeping/data/event/game_board_event.dart';
import 'package:mine_sweeping/models/game_level.dart';

class GameSettingDialog extends Dialog {
  final GameBoardBloc bloc;

  GameSettingDialog(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GameSettingDialogWidget(bloc),
    );
  }
}

class GameSettingDialogWidget extends StatefulWidget {
  final GameBoardBloc bloc;

  GameSettingDialogWidget(this.bloc);

  @override
  _GameSettingDialogWidgetState createState() =>
      _GameSettingDialogWidgetState();
}

class _GameSettingDialogWidgetState extends State<GameSettingDialogWidget> {
  String _selectLevel = "";

  TextEditingController customHeight = TextEditingController();
  TextEditingController customWidth = TextEditingController();
  TextEditingController customBomb = TextEditingController();

  @override
  void initState() {
    _selectLevel = widget.bloc.mineBoard.gameLevel.name;
    customHeight.text =
        GameGlobalManager().customizedGameLevel?.height.toString();
    customWidth.text =
        GameGlobalManager().customizedGameLevel?.width.toString();
    customBomb.text =
        GameGlobalManager().customizedGameLevel?.bombNumber.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 210,
      color: LocalColor.setting_bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ///top bard
          Container(
            padding: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  LocalString.home_bar_option_game,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      decoration: TextDecoration.none),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),

          ///sheet
          Container(
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(120.0),
                1: FixedColumnWidth(60.0),
                2: FixedColumnWidth(60.0),
                3: FixedColumnWidth(60.0),
              },
              children: [
                ///header
                TableRow(children: [
                  Container(),
                  Center(
                    child: Text(
                      LocalString.game_setting_height,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Center(
                    child: Text(
                      LocalString.game_setting_width,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Center(
                    child: Text(
                      LocalString.game_setting_mines,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ]),

                ///easy
                TableRow(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectLevel = GameLevel.EASY.name;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GameLevel.EASY.name == _selectLevel
                                ? Icon(
                                    Icons.check,
                                    size: 10.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 10.0,
                                    color: Colors.blue,
                                  ),
                          ),
                        ),
                      ),
                      Text(
                        GameLevel.EASY.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.EASY.height.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.EASY.width.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.EASY.bombNumber.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ], decoration: BoxDecoration(color: Colors.black12)),

                /// medium
                TableRow(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectLevel = GameLevel.MEDIUM.name;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GameLevel.MEDIUM.name == _selectLevel
                                ? Icon(
                                    Icons.check,
                                    size: 10.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 10.0,
                                    color: Colors.blue,
                                  ),
                          ),
                        ),
                      ),
                      Text(
                        GameLevel.MEDIUM.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.MEDIUM.height.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.MEDIUM.width.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.MEDIUM.bombNumber.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ], decoration: BoxDecoration(color: Colors.black12)),

                /// hard
                TableRow(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectLevel = GameLevel.HARD.name;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GameLevel.HARD.name == _selectLevel
                                ? Icon(
                                    Icons.check,
                                    size: 10.0,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 10.0,
                                    color: Colors.blue,
                                  ),
                          ),
                        ),
                      ),
                      Text(
                        GameLevel.HARD.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.HARD.height.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.HARD.width.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        GameLevel.HARD.bombNumber.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ], decoration: BoxDecoration(color: Colors.black12)),

                ///customized
                TableRow(children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectLevel =
                                GameGlobalManager().customizedGameLevel.name;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child:
                                GameGlobalManager().customizedGameLevel.name ==
                                        _selectLevel
                                    ? Icon(
                                        Icons.check,
                                        size: 10.0,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 10.0,
                                        color: Colors.blue,
                                      ),
                          ),
                        ),
                      ),
                      Text(
                        GameGlobalManager().customizedGameLevel.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 40,
                      child: Material(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: customHeight,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 40,
                      child: Material(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: customWidth,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 40,
                      child: Material(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: customBomb,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ),
                ], decoration: BoxDecoration(color: Colors.black12))
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left:5),
            child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 30,
                  height: 20,
                  child: RaisedButton(
                    onPressed: () {
                      widget.bloc
                          .add(NewGameEvent(gameLevel: getSelectedGameLevel()));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      LocalString.game_setting_new_game,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  GameLevel getSelectedGameLevel() {
    if (_selectLevel == GameLevel.EASY.name) {
      return GameLevel.EASY;
    }
    if (_selectLevel == GameLevel.MEDIUM.name) {
      return GameLevel.MEDIUM;
    }
    if (_selectLevel == GameLevel.HARD.name) {
      return GameLevel.HARD;
    }

    ///customized game level
    ///
    int cHeight = FormatHelper.getDigitFromString(customHeight.text);
    int cWidth = FormatHelper.getDigitFromString(customWidth.text);
    int cBomb = FormatHelper.getDigitFromString(customBomb.text);
    cHeight = min(
        BoardStaticSetting.maxBoardHeight, max(cHeight, BoardStaticSetting.minBoardHeight));
    cWidth =
        min(BoardStaticSetting.maxBoardWidth, max(cWidth, BoardStaticSetting.minBoardWidth));
    cBomb = min(cBomb, cHeight*cWidth -1);

    GameGlobalManager().customizedGameLevel =
        GameLevel(cWidth, cHeight, cBomb, 3, LocalString.game_setting_custom);

    return GameGlobalManager().customizedGameLevel;
  }
}
