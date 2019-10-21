import 'package:mine_sweeping/constant/strings.dart';

import 'base/base_enum.dart';

class GameLevel extends BaseEnum {
  final int width;
  final int height;
  final int bombNumber;

  const GameLevel(this.width, this.height, this.bombNumber, int id, String name)
      : super(id, name);

  static const GameLevel EASY =
      const GameLevel(9, 9, 10, 0, LocalString.game_setting_beginner);
  static const GameLevel MEDIUM =
      const GameLevel(16, 16, 40, 1, LocalString.game_setting_intermediate);
  static const GameLevel HARD =
      const GameLevel(16, 30, 99, 2, LocalString.game_setting_expert);
}
