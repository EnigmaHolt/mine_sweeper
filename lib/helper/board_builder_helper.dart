import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mine_sweeping/constant/colors.dart';

class BoardBuilderHelper {
  static Color getColorByAroundBombNumber(int number) {
    switch (number) {
      case 1:
        return LocalColor.bomb_1;
      case 2:
        return LocalColor.bomb_2;
      case 3:
        return LocalColor.bomb_3;
      case 4:
        return LocalColor.bomb_4;
      case 5:
        return LocalColor.bomb_5;
      case 6:
        return LocalColor.bomb_6;
      case 7:
        return LocalColor.bomb_7;
      case 8:
        return LocalColor.bomb_8;
      default:
        return LocalColor.bomb_1;
    }
  }


}
