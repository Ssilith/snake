import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake/core/models/direction.dart';
import 'package:snake/core/models/game_state.dart';
import 'package:snake/core/models/game_status.dart';
import 'package:snake/core/models/snake_segment.dart';
import 'package:snake/features/game/widgets/game_board.dart';
import 'package:snake/features/drawer/pages/snake_drawer.dart';
import 'package:snake/features/game/widgets/background_box.dart';
import 'package:snake/core/services/image_preloader.dart';
import 'package:snake/core/constants/game_constants.dart';
import 'package:snake/core/utils/game_utils.dart';

class SnakePage extends StatefulWidget {
  const SnakePage({super.key});

  @override
  State<SnakePage> createState() => _SnakePageState();
}

class _SnakePageState extends State<SnakePage> {
  late GameState _gameState;
  Timer? _gameTimer;
  late final FocusNode _focusNode;

  //* For responsive
  int _gridCols = GameConstants.gridWidth;
  int _gridRows = GameConstants.gridHeight;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _gameState = GameState.initial();
    _spawnFood();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _gameTimer?.cancel();
    super.dispose();
  }

  //* Start game function
  void _startGame() {
    setState(() => _gameState = GameState.initial());
    _spawnFood();
    setState(
      () => _gameState = _gameState.copyWith(status: GameStatus.playing),
    );
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(
      Duration(milliseconds: _gameState.gameSpeed),
      (_) => _updateGame(),
    );
  }

  //* Game over function
  void _gameOver() async {
    _gameTimer?.cancel();
    setState(
      () => _gameState = _gameState.copyWith(status: GameStatus.gameOver),
    );
  }

  //* Pause / resume game
  void _togglePause() {
    //* Only allow while the game is active
    if (!_gameState.isPlaying && !_gameState.isPaused) return;

    if (_gameState.isPaused) {
      //* Resume
      setState(
        () => _gameState = _gameState.copyWith(status: GameStatus.playing),
      );
      _gameTimer?.cancel();
      _gameTimer = Timer.periodic(
        Duration(milliseconds: _gameState.gameSpeed),
        (_) => _updateGame(),
      );
    } else {
      //* Pause
      _gameTimer?.cancel();
      setState(() {
        _gameState = _gameState.copyWith(status: GameStatus.paused);
      });
    }
  }

  //* Spawn new food
  void _spawnFood() {
    setState(() {
      _gameState = _gameState.copyWith(
        food: GameUtils.spawnFood(
          _gameState.snake,
          GameConstants.numberOfApples,
          _gridCols,
          _gridRows,
        ),
      );
    });
  }

  //* Navigate snake
  void _changeDirection(Direction newDirection) {
    if (!GameUtils.isValidDirectionChange(_gameState.direction, newDirection)) {
      return;
    }
    setState(
      () => _gameState = _gameState.copyWith(nextDirection: newDirection),
    );
  }

  //* Update game function
  void _updateGame() {
    if (!_gameState.isPlaying || _gameState.isPaused) return;

    //* Direction
    Direction currentDirection = _gameState.direction;
    if (_gameState.nextDirection != null) {
      currentDirection = _gameState.nextDirection!;
    }

    //* Head
    final head = _gameState.snake.first;
    final newHead = GameUtils.getNewHeadPosition(head, currentDirection);

    //* Is game over
    if (!GameUtils.isWithinBounds(newHead, _gridCols, _gridRows)) {
      _gameOver();
      return;
    }
    if (_gameState.snake.contains(newHead)) {
      _gameOver();
      return;
    }

    setState(() {
      //* Eaten food
      final newSnake = [newHead, ..._gameState.snake];
      final eatenIdx = _gameState.food.indexWhere((f) => f == newHead);

      if (eatenIdx != -1) {
        final newFood = List<SnakeSegment>.from(_gameState.food)
          ..removeAt(eatenIdx)
          ..add(
            GameUtils.generateFoodPosition(
              _gameState.snake,
              _gameState.food,
              _gridCols,
              _gridRows,
            ),
          );

        //* New speed
        final newSpeed = GameUtils.calculateNewSpeed(_gameState.gameSpeed);
        final oldSpeed = _gameState.gameSpeed;

        _gameState = _gameState.copyWith(
          snake: newSnake,
          food: newFood,
          direction: currentDirection,
          score: _gameState.score + GameConstants.pointsPerApple,
          applesCollected: _gameState.applesCollected + 1,
          gameSpeed: newSpeed,
        );

        if (newSpeed != oldSpeed) {
          _gameTimer?.cancel();
          _gameTimer = Timer.periodic(
            Duration(milliseconds: newSpeed),
            (_) => _updateGame(),
          );
        }
      } else {
        //* Not eaten - navigate
        newSnake.removeLast();
        _gameState = _gameState.copyWith(
          snake: newSnake,
          direction: currentDirection,
        );
      }
    });
  }

  //* Handle keys
  void _handleKeyPress(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    final key = event.logicalKey;

    //* Start game - enter
    if ((_gameState.isReady || _gameState.isGameOver) &&
        key == LogicalKeyboardKey.enter) {
      _startGame();
      return;
    }

    //* Pause / resume - space
    if (key == LogicalKeyboardKey.space) {
      _togglePause();
      return;
    }

    if (!_gameState.isPlaying || _gameState.isPaused) return;

    //* Navigate - arrows / WASD
    if (key == LogicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.keyW) {
      _changeDirection(Direction.up);
    } else if (key == LogicalKeyboardKey.arrowDown ||
        key == LogicalKeyboardKey.keyS) {
      _changeDirection(Direction.down);
    } else if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.keyA) {
      _changeDirection(Direction.left);
    } else if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.keyD) {
      _changeDirection(Direction.right);
    }
  }

  //* Change grid for responsive
  void _onGridSizeChanged(int cols, int rows) {
    if (cols == _gridCols && rows == _gridRows) return;
    setState(() {
      _gridCols = cols;
      _gridRows = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImagePreloader(
        //* Key presses
        child: KeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKeyPress,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final showDrawer =
                    constraints.maxWidth >= GameConstants.minWidthForDrawer;
                return Row(
                  children: [
                    //* Drawer
                    if (showDrawer)
                      BackgroundBox(
                        child: SnakeDrawer(
                          gameState: _gameState,
                          onStartGame: _startGame,
                          onTogglePause: _togglePause,
                        ),
                      ),
                    //* Game board
                    Expanded(
                      child: BackgroundBox(
                        child: GameBoard(
                          gameState: _gameState,
                          onStartGame: _startGame,
                          onDirectionChange: _changeDirection,
                          onGridSizeChanged: _onGridSizeChanged,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
