import 'package:flutter/material.dart';
import 'package:snake/core/models/direction.dart';
import 'package:snake/core/models/snake_segment.dart';
import 'package:snake/core/services/game_assets.dart';

class AssetHelper {
  //* Snake head
  static AssetImage getHeadAsset(Direction direction) {
    switch (direction) {
      case Direction.up:
        return GameAssets.headUp;
      case Direction.down:
        return GameAssets.headDown;
      case Direction.left:
        return GameAssets.headLeft;
      case Direction.right:
        return GameAssets.headRight;
    }
  }

  //* Snake tail
  static AssetImage getTailAsset(SnakeSegment tail, SnakeSegment prev) {
    final dx = prev.x - tail.x;
    final dy = prev.y - tail.y;
    if (dx == 1) return GameAssets.tailLeft;
    if (dx == -1) return GameAssets.tailRight;
    if (dy == 1) return GameAssets.tailUp;
    if (dy == -1) return GameAssets.tailDown;
    return GameAssets.tailLeft;
  }

  //* Snake body
  static AssetImage getBodyAsset(
    SnakeSegment current,
    SnakeSegment prev,
    SnakeSegment next,
  ) {
    final dx1 = current.x - prev.x;
    final dy1 = current.y - prev.y;
    final dx2 = next.x - current.x;
    final dy2 = next.y - current.y;

    if (dx1 == dx2 && dy1 == dy2) {
      return dx1 != 0 ? GameAssets.bodyHorizontal : GameAssets.bodyVertical;
    }
    if ((dx1 == 1 && dy2 == -1) || (dy1 == 1 && dx2 == -1)) {
      return GameAssets.bodyUpLeft;
    }
    if ((dx1 == 1 && dy2 == 1) || (dy1 == -1 && dx2 == -1)) {
      return GameAssets.bodyDownLeft;
    }
    if ((dx1 == -1 && dy2 == -1) || (dy1 == 1 && dx2 == 1)) {
      return GameAssets.bodyUpRight;
    }
    if ((dx1 == -1 && dy2 == 1) || (dy1 == -1 && dx2 == 1)) {
      return GameAssets.bodyDownRight;
    }
    return GameAssets.bodyHorizontal;
  }

  //* Snake segment
  static AssetImage getSnakeSegmentAsset(
    int index,
    List<SnakeSegment> snake,
    Direction direction,
  ) {
    if (index == 0) return getHeadAsset(direction);
    if (index == snake.length - 1) {
      return getTailAsset(snake[index], snake[index - 1]);
    }
    return getBodyAsset(snake[index], snake[index - 1], snake[index + 1]);
  }

  //* Fence
  static AssetImage? getFenceAsset({
    required bool isTopEdge,
    required bool isBottomEdge,
    required bool isLeftEdge,
    required bool isRightEdge,
  }) {
    if (isTopEdge && isLeftEdge) return GameAssets.fenceTopLeft;
    if (isTopEdge && isRightEdge) return GameAssets.fenceTopRight;
    if (isBottomEdge && isRightEdge) return GameAssets.fenceBottomLeft;
    if (isBottomEdge && isLeftEdge) return GameAssets.fenceBottomRight;
    if (isTopEdge || isBottomEdge) return GameAssets.fenceHorizontal;
    if (isLeftEdge || isRightEdge) return GameAssets.fenceVertical;
    return null;
  }
}
