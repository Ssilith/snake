import 'package:flutter/material.dart';

enum GameStatus {
  ready,
  playing,
  paused,
  gameOver;

  Color get color {
    switch (this) {
      case GameStatus.playing:
        return Colors.green;
      case GameStatus.paused:
        return Colors.grey;
      case GameStatus.gameOver:
        return Colors.red;
      case GameStatus.ready:
        return Colors.orange;
    }
  }

  String get name {
    switch (this) {
      case GameStatus.playing:
        return 'PLAYING';
      case GameStatus.paused:
        return 'PAUSED';
      case GameStatus.gameOver:
        return 'GAME OVER';
      case GameStatus.ready:
        return 'READY';
    }
  }
}
