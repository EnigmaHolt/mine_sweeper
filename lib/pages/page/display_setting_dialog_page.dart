import 'package:flutter/material.dart';
import 'package:mine_sweeping/blocs/game_board_bloc.dart';
import 'package:mine_sweeping/common/board_config.dart';
import 'package:mine_sweeping/common/board_static_setting.dart';
import 'package:mine_sweeping/constant/colors.dart';
import 'package:mine_sweeping/constant/strings.dart';
import 'package:mine_sweeping/data/event/game_board_event.dart';



///Setting dialog for controlling the board display size
///
/// display based on [HomeTopBar]
/// other setting page [ControlSettingDialog] [GameSettingDialog]

class DisplaySettingDialog extends Dialog {
  final GameBoardBloc bloc;

  DisplaySettingDialog(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DisplaySettingDialogState(bloc),
    );
  }
}

class DisplaySettingDialogState extends StatefulWidget {
  final GameBoardBloc bloc;

  DisplaySettingDialogState(this.bloc);

  @override
  _DisplaySettingDialogStateState createState() =>
      _DisplaySettingDialogStateState();
}

class _DisplaySettingDialogStateState extends State<DisplaySettingDialogState> {
  double selectedScale = BoardStaticSetting.selectScale;

  ///0 center, 1 left
  int currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 210,
      color: LocalColor.setting_bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ///top bar
          Container(
            padding: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  LocalString.home_bar_option_display,
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
          //zoom
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    LocalString.display_setting_zoom,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedScale = 1.0;
                              onChange();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: selectedScale == 1.0
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
                          LocalString.display_setting_zoom_100,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedScale = 1.5;
                              onChange();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: selectedScale == 1.5
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
                          LocalString.display_setting_zoom_150,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedScale = 2.0;
                              onChange();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: selectedScale == 2.0
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
                          LocalString.display_setting_zoom_200,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 1,
            color: Colors.black,
          ),
          //position
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    LocalString.display_setting_position,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPosition = 0;
                              onChange();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: currentPosition == 0
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
                          LocalString.display_setting_position_center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPosition = 1;
                              onChange();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: currentPosition == 1
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
                          LocalString.display_setting_position_left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              decoration: TextDecoration.none),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void onChange() {
    BoardStaticSetting.selectScale = selectedScale;
    widget.bloc.add(DisplayChangeEvent(selectedScale, currentPosition));
  }
}
