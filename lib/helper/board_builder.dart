import 'package:mine_sweeping/data/enum_game_status.dart';
import 'package:mine_sweeping/data/enum_user_action.dart';
import 'package:mine_sweeping/models/base/base_board_tile.dart';
import 'package:mine_sweeping/models/bomb_board_tile.dart';
import 'package:mine_sweeping/models/game_level.dart';
import 'package:mine_sweeping/models/safe_board_tile.dart';

import 'board_build_strategy.dart';

class MineBoard {
  final GameLevel gameLevel;

  List<List<BaseBoardTile>> tiles;

  int get totalTiles {
    return gameLevel.width * gameLevel.height;
  }

  int get boardHeight {
    return gameLevel.height;
  }

  int get boardWidth {
    return gameLevel.width;
  }

  int get bombNumber {
    return gameLevel.bombNumber;
  }

  MineBoard({this.gameLevel = GameLevel.MEDIUM}) {
    tiles = BoardBuildStrategy()
        .generateBoard(gameLevel.bombNumber, gameLevel.width, gameLevel.height);
  }
}
