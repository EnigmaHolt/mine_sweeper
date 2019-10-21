import 'dart:math';

import 'package:mine_sweeping/constant/strings.dart';
import 'package:mine_sweeping/models/base/base_board_tile.dart';
import 'package:mine_sweeping/models/bomb_board_tile.dart';
import 'package:mine_sweeping/models/safe_board_tile.dart';


/// decide how to build the whole board.
///
/// [MineBoard]
abstract class BoardBuildStrategy {
  factory BoardBuildStrategy(
      {BoardBuildStrategyType type = BoardBuildStrategyType.RANDOM}) {
    switch (type) {
      case BoardBuildStrategyType.RANDOM:
        return RandomStrategy();
      default:
        throw (ExceptionString.boardBuilderStrategyError);
    }
  }

  List<List<BaseBoardTile>> generateBoard(
      int bombNumber, int boardWidth, int boardHeight);
}

class RandomStrategy implements BoardBuildStrategy {
  @override
  List<List<BaseBoardTile>> generateBoard(
      int bombNumber, int boardWidth, int boardHeight) {
    bool randomBomb = boardWidth * boardHeight > 2 * bombNumber;

    List<List<BaseBoardTile>> tiles = List.generate(boardHeight, (i) {
      return List.generate(boardWidth, (j) {
        return randomBomb ? SafeBoardTile() : BombBoardTile();
      });
    });

    int remainTileNumber =
        randomBomb ? bombNumber : (boardHeight * boardWidth - bombNumber);

    Random random = new Random();

    while (remainTileNumber > 0) {
      int randomX = random.nextInt(boardHeight);
      int randomY = random.nextInt(boardWidth);

      if (randomBomb && tiles[randomX][randomY] is SafeBoardTile) {
        tiles[randomX][randomY] = BombBoardTile();

        ///update around safe
        remainTileNumber--;
      } else if (!randomBomb && tiles[randomX][randomY] is BombBoardTile) {
        tiles[randomX][randomY] = SafeBoardTile();

        ///update around safe
        remainTileNumber--;
      }
    }

    ///process the bombNumber in safeTile
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[i].length; j++) {
        if (tiles[i][j] is SafeBoardTile) {
          SafeBoardTile tile = tiles[i][j];

          if (i > 0 && j > 0 && (tiles[i - 1][j - 1] is BombBoardTile))
            tile.aroundBombNumber++;
          if (i > 0 && (tiles[i - 1][j] is BombBoardTile))
            tile.aroundBombNumber++;
          if (i > 0 &&
              j < tiles[i].length - 1 &&
              (tiles[i - 1][j + 1] is BombBoardTile)) tile.aroundBombNumber++;
          if (j > 0 && (tiles[i][j - 1] is BombBoardTile))
            tile.aroundBombNumber++;
          if (j < tiles[i].length - 1 && (tiles[i][j + 1] is BombBoardTile))
            tile.aroundBombNumber++;

          if (i < tiles.length - 1 &&
              j > 0 &&
              (tiles[i + 1][j - 1] is BombBoardTile)) tile.aroundBombNumber++;

          if (i < tiles.length - 1 && (tiles[i + 1][j] is BombBoardTile))
            tile.aroundBombNumber++;

          if (i < tiles.length - 1 &&
              j < tiles[i].length - 1 &&
              (tiles[i + 1][j + 1] is BombBoardTile)) tile.aroundBombNumber++;
        }
      }
    }

    return tiles;
  }
}

enum BoardBuildStrategyType {
  RANDOM,
}
