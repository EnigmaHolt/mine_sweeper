abstract class GameBoardState {
  String getEventName();
}

class GameInitState extends GameBoardState {
  @override
  String getEventName() => 'GameInitState';
}

class BoardRefreshState extends GameBoardState {
  @override
  String getEventName() => 'BoardRefreshState';
}

class TimingStartState extends GameBoardState {
  @override
  String getEventName() => 'TimingStartState';
}

class CheckTileAroundState extends GameBoardState {
  int x;
  int y;

  CheckTileAroundState(this.x, this.y);

  @override
  String getEventName() => 'TimingStartState';
}

class BoardDisplayChangeState extends GameBoardState {
  double scale;
  int position;

  BoardDisplayChangeState(this.scale, this.position);

  @override
  String getEventName() => 'BoardDisplayChangeState';
}

class GameOverState extends GameBoardState {
  @override
  String getEventName() => 'GameOverState';
}

class GameWinState extends GameBoardState {
  @override
  String getEventName() => 'GameWinState';
}

class UploadRecordState extends GameBoardState {
  int time;

  UploadRecordState(this.time);

  @override
  String getEventName() {
    return "UploadRecordState";
  }
}
