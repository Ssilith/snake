class GameConstants {
  //* Grid dimensions
  static const int gridWidth = 30;
  static const int gridHeight = 20;

  //* Asset pixel sizes
  static const double fenceSize = 32.0;
  static const double snakeAssetSize = 64.0;

  //* Game mechanics
  static const int initialGameSpeed = 300; //? ms per tick (higher = slower)
  static const int minGameSpeed = 20; //? fastest the game can get (ms)
  static const int speedIncrementPerApple = 30;
  static const int pointsPerApple = 10;
  static const int numberOfApples = 3;

  //* Layout
  static const double drawerWidth = 292.0;
  static const double minWidthForDrawer = 1000.0;

  //* Colors
  static const int boardColor = 0xFF84AA5F;
  static const int fenceColor = 0xFF2a1a0a;
}
