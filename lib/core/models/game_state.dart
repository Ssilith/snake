import 'package:snake/core/constants/game_constants.dart';
import 'package:snake/core/models/direction.dart';
import 'package:snake/core/models/game_status.dart';
import 'package:snake/core/models/snake_segment.dart';

class GameState {
  final List<SnakeSegment> snake;
  final List<SnakeSegment> food;
  final Direction direction;
  final Direction? nextDirection;
  final GameStatus status;
  final int score;
  final int applesCollected;
  final int gameSpeed;

  const GameState({
    required this.snake,
    required this.food,
    required this.direction,
    this.nextDirection,
    required this.status,
    required this.score,
    required this.applesCollected,
    required this.gameSpeed,
  });

  bool get isPlaying => status == GameStatus.playing;
  bool get isPaused => status == GameStatus.paused;
  bool get isGameOver => status == GameStatus.gameOver;
  bool get isReady => status == GameStatus.ready;
  bool get hasStarted => status != GameStatus.ready;

  GameState copyWith({
    List<SnakeSegment>? snake,
    List<SnakeSegment>? food,
    Direction? direction,
    Direction? nextDirection,
    GameStatus? status,
    int? score,
    int? applesCollected,
    int? gameSpeed,
  }) {
    return GameState(
      snake: snake ?? this.snake,
      food: food ?? this.food,
      direction: direction ?? this.direction,
      nextDirection: nextDirection ?? this.nextDirection,
      status: status ?? this.status,
      score: score ?? this.score,
      applesCollected: applesCollected ?? this.applesCollected,
      gameSpeed: gameSpeed ?? this.gameSpeed,
    );
  }

  factory GameState.initial() {
    return const GameState(
      snake: [SnakeSegment(12, 12), SnakeSegment(11, 12)],
      food: [],
      direction: Direction.right,
      status: GameStatus.ready,
      score: 0,
      applesCollected: 0,
      gameSpeed: GameConstants.initialGameSpeed,
    );
  }
}
