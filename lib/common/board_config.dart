class BoardConfig {


  double scale = 1;

  BoardConfig(this.scale) {
    tileSize = 15 * scale;
    timerFontMaxSize = 25 * scale;
    resetButtonSize = 30 * scale;
    boardEdgeWidth = 2 * scale;
    controlBarHeight = 50 * scale;
  }

  double tileSize;
  double timerFontMaxSize;

  double resetButtonSize;

  double boardEdgeWidth;
  double controlBarHeight;



}
