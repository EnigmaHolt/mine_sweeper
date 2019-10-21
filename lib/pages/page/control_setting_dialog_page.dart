import 'package:flutter/material.dart';
import 'package:mine_sweeping/constant/colors.dart';
import 'package:mine_sweeping/constant/strings.dart';

///Setting dialog for explaining the control instruction for user
///
/// display based on [HomeTopBar]
/// other setting page [DisplaySettingDialog] [GameSettingDialog]
class ControlSettingDialog extends Dialog {
  ControlSettingDialog();

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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  LocalString.home_bar_option_controls,
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
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    LocalString.control_setting_desktop,
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
                    Text(
                      LocalString.control_setting_desktop_click,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      LocalString.control_setting_desktop_long_click,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      LocalString.control_setting_desktop_click_number,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          decoration: TextDecoration.none),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
