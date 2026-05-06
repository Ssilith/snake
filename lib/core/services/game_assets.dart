import 'package:flutter/material.dart';

class GameAssets {
  //* Snake head assets
  static const AssetImage headUp = AssetImage('assets/head_up.png');
  static const AssetImage headDown = AssetImage('assets/head_down.png');
  static const AssetImage headLeft = AssetImage('assets/head_left.png');
  static const AssetImage headRight = AssetImage('assets/head_right.png');

  //* Snake tail assets
  static const AssetImage tailUp = AssetImage('assets/tail_up.png');
  static const AssetImage tailDown = AssetImage('assets/tail_down.png');
  static const AssetImage tailLeft = AssetImage('assets/tail_left.png');
  static const AssetImage tailRight = AssetImage('assets/tail_right.png');

  //* Snake body assets
  static const AssetImage bodyHorizontal = AssetImage(
    'assets/body_horizontal.png',
  );
  static const AssetImage bodyVertical = AssetImage('assets/body_vertical.png');
  static const AssetImage bodyUpLeft = AssetImage('assets/body_up_left.png');
  static const AssetImage bodyUpRight = AssetImage('assets/body_up_right.png');
  static const AssetImage bodyDownLeft = AssetImage(
    'assets/body_down_left.png',
  );
  static const AssetImage bodyDownRight = AssetImage(
    'assets/body_down_right.png',
  );

  //* Food asset
  static const AssetImage apple = AssetImage('assets/apple.png');

  //* Fence assets
  static const AssetImage fenceTopLeft = AssetImage('assets/top_left.png');
  static const AssetImage fenceTopRight = AssetImage('assets/top_right.png');
  static const AssetImage fenceBottomLeft = AssetImage(
    'assets/bottom_left.png',
  );
  static const AssetImage fenceBottomRight = AssetImage(
    'assets/bottom_right.png',
  );
  static const AssetImage fenceHorizontal = AssetImage('assets/horizontal.png');
  static const AssetImage fenceVertical = AssetImage('assets/vertical.png');

  //* All for preloading
  static List<AssetImage> getAllAssets() => [
    headUp,
    headDown,
    headLeft,
    headRight,
    tailUp,
    tailDown,
    tailLeft,
    tailRight,
    bodyHorizontal,
    bodyVertical,
    bodyUpLeft,
    bodyUpRight,
    bodyDownLeft,
    bodyDownRight,
    apple,
    fenceTopLeft,
    fenceTopRight,
    fenceBottomLeft,
    fenceBottomRight,
    fenceHorizontal,
    fenceVertical,
  ];
}
