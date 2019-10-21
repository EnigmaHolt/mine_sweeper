import 'package:mine_sweeping/constant/strings.dart';
import 'package:mine_sweeping/models/game_level.dart';

class GameGlobalManager {
  static GameGlobalManager _instance = GameGlobalManager._internal();

  factory GameGlobalManager() => _instance;

  GameGlobalManager._internal();

  GameLevel customizedGameLevel = GameLevel(30, 20, 145, 3, LocalString.game_setting_custom);



}
