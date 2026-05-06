import 'package:flutter/material.dart';
import 'package:snake/core/models/game_state.dart';
import 'package:snake/features/game/widgets/board_gradient.dart';
import 'package:snake/core/utils/fence_utils.dart';
import 'package:snake/features/game/widgets/game_overlay.dart';
import 'package:snake/features/game/widgets/image_position.dart';
import 'package:snake/core/services/asset_helper.dart';
import 'package:snake/core/services/game_assets.dart';

class GameArea extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onStartGame;
  final double cellSize;
  final double fenceSize;
  final double availW;
  final double availH;
  final double boardW;
  final double boardH;
  const GameArea({
    super.key,
    required this.gameState,
    required this.onStartGame,
    required this.cellSize,
    required this.fenceSize,
    required this.availW,
    required this.availH,
    required this.boardW,
    required this.boardH,
  });

  @override
  Widget build(BuildContext context) {
    //* Total pixel size of the fence-bordered rectangle
    final double totalW = fenceSize * 2 + boardW;
    final double totalH = fenceSize * 2 + boardH;

    //* How far to push the rectangle so it sits centered inside availW x availH
    final double offsetX = (availW - totalW) / 2;
    final double offsetY = (availH - totalH) / 2;

    //* Top-left corner of each fence edge
    final double fenceLeft = offsetX;
    final double fenceTop = offsetY;
    final double fenceRight = offsetX + fenceSize + boardW;
    final double fenceBottom = offsetY + fenceSize + boardH;

    //* The playable board begins one fence tile inward from the top-left corner
    final double boardLeft = offsetX + fenceSize;
    final double boardTop = offsetY + fenceSize;

    //* Show opacity on board
    final bool showOverlay =
        gameState.isReady || gameState.isPaused || gameState.isGameOver;

    return Stack(
      children: [
        Opacity(
          opacity: showOverlay ? 0.5 : 1,
          //* Gradient
          child: BoardGradient(
            availH: availH,
            availW: availW,
            child: Stack(
              children: [
                //* Area to play
                Positioned(
                  left: boardLeft,
                  top: boardTop,
                  width: boardW,
                  height: boardH,
                  child: Stack(
                    children: [
                      //* Apples
                      ...gameState.food.map(
                        (pos) => ImagePosition(
                          left: pos.x * cellSize,
                          top: pos.y * cellSize,
                          width: cellSize,
                          height: cellSize,
                          asset: GameAssets.apple,
                        ),
                      ),
                      //* Snake
                      ...List.generate(gameState.snake.length, (idx) {
                        final seg = gameState.snake[idx];
                        final asset = AssetHelper.getSnakeSegmentAsset(
                          idx,
                          gameState.snake,
                          gameState.direction,
                        );
                        return ImagePosition(
                          left: seg.x * cellSize,
                          top: seg.y * cellSize,
                          width: cellSize,
                          height: cellSize,
                          asset: asset,
                        );
                      }),
                    ],
                  ),
                ),
                //* Fence
                ...FenceUtils.buildTopRow(
                  fenceLeft,
                  fenceTop,
                  fenceRight,
                  fenceSize,
                ),
                ...FenceUtils.buildBottomRow(
                  fenceLeft,
                  fenceBottom,
                  fenceRight,
                  fenceSize,
                ),
                ...FenceUtils.buildLeftCol(
                  fenceLeft,
                  fenceTop,
                  fenceBottom,
                  fenceSize,
                ),
                ...FenceUtils.buildRightCol(
                  fenceRight,
                  fenceTop,
                  fenceBottom,
                  fenceSize,
                ),
              ],
            ),
          ),
        ),

        //* Game ready overlay
        if (gameState.isReady)
          Positioned(
            left: boardLeft,
            top: boardTop,
            width: boardW,
            height: boardH,
            child: const GameOverlay(
              titleIconData: Icons.play_arrow_rounded,
              title: "START GAME",
              subtitleIconData: Icons.keyboard_rounded,
              subtitle: 'Press Enter to start',
            ),
          )
        //* Game paused overlay
        else if (gameState.isPaused)
          Positioned(
            left: boardLeft,
            top: boardTop,
            width: boardW,
            height: boardH,
            child: const GameOverlay(
              titleIconData: Icons.pause_circle_outline_rounded,
              title: "PAUSED",
              subtitleIconData: Icons.keyboard_rounded,
              subtitle: 'Press Space to resume',
            ),
          )
        //* Game over overlay
        else if (gameState.isGameOver)
          Positioned(
            left: boardLeft,
            top: boardTop,
            width: boardW,
            height: boardH,
            child: GameOverlay(
              titleIconData: Icons.sentiment_dissatisfied_rounded,
              title: 'GAME OVER',
              subtitleIconData: Icons.stars_rounded,
              subtitle: 'Score: ${gameState.score}',
              buttonTitle: 'PLAY AGAIN',
              onButtonTap: onStartGame,
            ),
          ),
      ],
    );
  }
}
