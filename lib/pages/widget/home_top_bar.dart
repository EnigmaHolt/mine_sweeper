import 'package:flutter/material.dart';
import 'package:mine_sweeping/blocs/game_board_bloc.dart';
import 'package:mine_sweeping/constant/strings.dart';
import 'package:mine_sweeping/pages/page/control_setting_dialog_page.dart';
import 'package:mine_sweeping/pages/page/display_setting_dialog_page.dart';
import 'package:mine_sweeping/pages/page/game_dialog_page.dart';

class HomeTopBar extends StatelessWidget {
  final GameBoardBloc bloc;

  HomeTopBar(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return GameSettingDialog(bloc);
                  });
            },
            child: Text(LocalString.home_bar_option_game,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: Colors.blueAccent)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Container(
              width: 1,
              color: Colors.black,
              height: 10,
            ),
          ),
          GestureDetector(
            child: Text(LocalString.home_bar_option_display,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: Colors.blueAccent)),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DisplaySettingDialog(bloc);
                  });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Container(width: 1, color: Colors.black, height: 10),
          ),
          GestureDetector(
            child: Text(LocalString.home_bar_option_controls,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    color: Colors.blueAccent)),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return ControlSettingDialog();
                  });
            },
          )
        ],
      ),
    );
  }
}
