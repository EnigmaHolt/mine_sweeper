import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:mine_sweeping/data/enum_game_status.dart';
import 'package:mine_sweeping/data/enum_mark_status.dart';
import 'package:mine_sweeping/data/enum_user_action.dart';

import 'package:mine_sweeping/data/event/game_board_event.dart';
import 'package:mine_sweeping/data/state/game_board_state.dart';
import 'package:mine_sweeping/models/base/base_board_tile.dart';
import 'package:mine_sweeping/models/bomb_board_tile.dart';
import 'package:mine_sweeping/helper/board_builder.dart';
import 'package:mine_sweeping/models/game_level.dart';
import 'package:mine_sweeping/models/safe_board_tile.dart';

class GameBoardBloc extends Bloc<GameBoardEvent, GameBoardState> {
  GameLevel selectGameLevel = GameLevel.MEDIUM;

  MineBoard mineBoard = MineBoard();
  GameStatus gameStatus = GameStatus.BEGIN;

  int get markedBombNumber {
    if (gameStatus == GameStatus.FAILED || gameStatus == GameStatus.WIN)
      return 0;

    int bombNumber = mineBoard.bombNumber;
    int totalMarkedFlag = 0;

    /// first check mark
    mineBoard.tiles.forEach((row) {
      row.forEach((tile) {
        if (tile.markStatus == TileMarkStatus.FLAG) {
          totalMarkedFlag++;
        }
      });
    });

    return bombNumber - totalMarkedFlag;
  }

  @override
  GameBoardState get initialState => GameInitState();

  @override
  Stream<GameBoardState> mapEventToState(GameBoardEvent event) async* {
    if (event is NewGameEvent) {
      if (event.gameLevel != null) selectGameLevel = event.gameLevel;
      mineBoard = MineBoard(gameLevel: selectGameLevel);
      gameStatus = GameStatus.BEGIN;

      yield GameInitState();
    } else if (event is UserBoardActionEvent) {
      /// check if user start the game
      if (gameStatus == GameStatus.BEGIN) {
        gameStatus = GameStatus.IN_PROCESS;
        yield TimingStartState();
        await Future.delayed(Duration(milliseconds: 100));
      }

      int x = event.x;
      int y = event.y;
      UserAction userAction = event.userAction;

      if (event.x >= 0 &&
          x <= mineBoard.boardHeight &&
          y >= 0 &&
          y < mineBoard.boardWidth) {
        /// get user selected tile
        BaseBoardTile tile = mineBoard.tiles[x][y];
        switch (userAction) {
          case UserAction.LEFT_CLICK:
            if (tile is SafeBoardTile &&
                tile.isOpen &&
                tile.aroundBombNumber > 0) {
              ///user is checking tile around
              yield (CheckTileAroundState(x, y));
            } else if (!tile.isOpen && tile is BombBoardTile) {
              ///user triggered a bomb, game failed
              tile.isTriggered = true;
              gameStatus = GameStatus.FAILED;
              openAllTilesInTheBoard(false);
              yield GameOverState();
            } else if (!tile.isOpen && tile is SafeBoardTile) {
              ///open closed tile
              if (tile.aroundBombNumber == 0) {
                processSuperSafeBoard(
                    new List.generate(
                        mineBoard.boardHeight,
                        (h) =>
                            List.generate(mineBoard.boardWidth, (w) => false)),
                    x,
                    y);
              } else {
                tile.isOpen = true;
              }

              ///check user is win or not.
              if (checkIsWin()) {
                gameStatus = GameStatus.WIN;

                openAllTilesInTheBoard(true);
                yield GameWinState();

              } else {
                yield BoardRefreshState();
              }
            }
            break;
          case UserAction.RIGHT_CLICK:
            break;
          case UserAction.LONG_CLICK:
            if (tile.isOpen) return;
            tile.toNextMarkStatus();

            yield BoardRefreshState();
            break;
          case UserAction.DOUBLE_TAP:
            break;
        }
      }
    } else if (event is OpenAllBoardEvent) {
      openAllTilesInTheBoard(false);
      yield BoardRefreshState();
    }else if(event is DisplayChangeEvent){
      yield BoardDisplayChangeState(event.scale,event.position);
    }
  }

  void openAllTilesInTheBoard(bool isWin) {
    mineBoard.tiles.forEach((t) {
      t.forEach((tile) {
        if (isWin && tile is BombBoardTile) {
          tile.markStatus = TileMarkStatus.FLAG;
        }
        tile.isOpen = true;
      });
    });
  }

  bool checkIsWin() {
//    int bombNumber = mineBoard.bombNumber;
//    int totalFlag = 0;
//
//    /// first check mark
//    mineBoard.tiles.forEach((row) {
//      row.forEach((tile) {
//        if (tile.markStatus == TileMarkStatus.FLAG && tile is BombBoardTile) {
//          bombNumber--;
//        }
//
//        if (tile.markStatus == TileMarkStatus.FLAG) {
//          totalFlag++;
//        }
//      });
//    });
//
//    if (bombNumber == 0 && totalFlag == mineBoard.bombNumber) return true;

    ///check if only bomb tiles are closed tiles
    int totalClosedSafeTile = 0;

    mineBoard.tiles.forEach((row) {
      row.forEach((tile) {
        if (!tile.isOpen) {
          totalClosedSafeTile++;
        }
      });
    });

    return totalClosedSafeTile == mineBoard.bombNumber;
  }

  void processSuperSafeBoard(List<List<bool>> seen, int x, int y) {
    if (x < 0 ||
        x >= mineBoard.boardHeight ||
        y < 0 ||
        y >= mineBoard.boardWidth) return;

    BaseBoardTile tile = mineBoard.tiles[x][y];

    if (tile.isOpen || seen[x][y]) return;

    seen[x][y] = true;

    if (tile is SafeBoardTile) {
      if (tile.markStatus == TileMarkStatus.NONE) tile.isOpen = true;

      if (tile.aroundBombNumber == 0) {
        ///process super safe board
        /// check left
        processSuperSafeBoard(seen, x, y - 1);

        /// check top
        processSuperSafeBoard(seen, x - 1, y);

        /// check right
        processSuperSafeBoard(seen, x, y + 1);

        /// check bottom
        processSuperSafeBoard(seen, x + 1, y);
      }
    }
    return;
  }
}
