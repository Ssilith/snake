import 'dart:math';

import 'package:snake/core/constants/game_constants.dart';
import 'package:snake/core/models/direction.dart';
import 'package:snake/core/models/snake_segment.dart';

class GameUtils {
  static final Random _random = Random();

  //* Generate a random food position
  static SnakeSegment generateFoodPosition(
    List<SnakeSegment> snake,
    List<SnakeSegment> existingFood,
    int gridCols,
    int gridRows,
  ) {
    SnakeSegment newFood;
    int attempts = 0;
    do {
      newFood = SnakeSegment(
        _random.nextInt(gridCols),
        _random.nextInt(gridRows),
      );
      attempts++;
    } while ((snake.contains(newFood) || existingFood.contains(newFood)) &&
        attempts < 100);
    return newFood;
  }

  //* Spawn food items
  static List<SnakeSegment> spawnFood(
    List<SnakeSegment> snake,
    int count,
    int gridCols,
    int gridRows,
  ) {
    final food = <SnakeSegment>[];
    for (int i = 0; i < count; i++) {
      food.add(generateFoodPosition(snake, food, gridCols, gridRows));
    }
    return food;
  }

  //* Check if a direction change is valid (cannot go directly backwards)
  static bool isValidDirectionChange(Direction current, Direction next) {
    if (current == Direction.up && next == Direction.down) return false;
    if (current == Direction.down && next == Direction.up) return false;
    if (current == Direction.left && next == Direction.right) return false;
    if (current == Direction.right && next == Direction.left) return false;
    return true;
  }

  //* Get the new head position based on current head and direction
  static SnakeSegment getNewHeadPosition(
    SnakeSegment currentHead,
    Direction direction,
  ) {
    switch (direction) {
      case Direction.up:
        return SnakeSegment(currentHead.x, currentHead.y - 1);
      case Direction.down:
        return SnakeSegment(currentHead.x, currentHead.y + 1);
      case Direction.left:
        return SnakeSegment(currentHead.x - 1, currentHead.y);
      case Direction.right:
        return SnakeSegment(currentHead.x + 1, currentHead.y);
    }
  }

  //* Check if position is within the actual rendered grid bounds
  static bool isWithinBounds(
    SnakeSegment position,
    int gridCols,
    int gridRows,
  ) {
    return position.x >= 0 &&
        position.x < gridCols &&
        position.y >= 0 &&
        position.y < gridRows;
  }

  //* Calculate new game speed after collecting an apple
  static int calculateNewSpeed(int currentSpeed) {
    return max(
      GameConstants.minGameSpeed,
      currentSpeed - GameConstants.speedIncrementPerApple,
    );
  }

  //* Calculate speed level
  static int calculateLevel(int currentSpeed) {
    const int initial = GameConstants.initialGameSpeed;
    const int min = GameConstants.minGameSpeed;
    final double progress = (initial - currentSpeed) / (initial - min);
    final int level = 1 + (progress * 9).floor();
    return level.clamp(1, 10);
  }
}
