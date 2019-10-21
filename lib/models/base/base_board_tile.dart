import 'package:flutter/material.dart';
import 'package:mine_sweeping/data/enum_mark_status.dart';

class BaseBoardTile{
  ///tile showing status
  bool isOpen = false;

  ///open reward
  int reward = 10;

  /// is marked by user
  TileMarkStatus markStatus = TileMarkStatus.NONE;

  void toNextMarkStatus(){
    switch(markStatus){
      case TileMarkStatus.NONE:
        markStatus = TileMarkStatus.FLAG;
        break;
      case TileMarkStatus.FLAG:
        markStatus = TileMarkStatus.NOT_SURE;

        break;
      case TileMarkStatus.NOT_SURE:
        markStatus = TileMarkStatus.NONE;

        break;
    }
  }
}
