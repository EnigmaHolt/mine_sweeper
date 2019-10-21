import 'package:mine_sweeping/data/enum_user_action.dart';
import 'package:mine_sweeping/models/game_level.dart';

abstract class GameBoardEvent {
  String getEventName();
}

class NewGameEvent extends GameBoardEvent {

  GameLevel gameLevel;

  NewGameEvent({this.gameLevel});

  @override
  String getEventName() => 'NewGameEvent';
}

class GameReadyEvent extends GameBoardEvent {



  @override
  String getEventName() => 'GameReadyEvent';
}

class GameOverEvent extends GameBoardEvent {
  GameOverEvent();

  @override
  String getEventName() => 'GameOverEvent';
}

class GameWinEvent extends GameBoardEvent {
  GameWinEvent();

  @override
  String getEventName() => 'GameWinEvent';
}

class OpenAllBoardEvent extends GameBoardEvent {
  OpenAllBoardEvent();

  @override
  String getEventName() => 'OpenAllBoardEvent';
}

class StarTimingEvent extends GameBoardEvent {

  @override
  String getEventName() => 'StarTimingEvent';
}

class DisplayChangeEvent extends GameBoardEvent {

  double scale;
  int position;


  DisplayChangeEvent(this.scale, this.position);

  @override
  String getEventName() => 'StarTimingEvent';
}


class UserBoardActionEvent extends GameBoardEvent {
  UserAction userAction; int x; int y;


  UserBoardActionEvent(this.userAction, this.x, this.y);

  @override
  String getEventName() => 'UserBoardActionEvent';
}
