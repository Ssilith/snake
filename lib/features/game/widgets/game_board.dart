import 'package:flutter/material.dart';
import 'package:snake/core/models/direction.dart';
import 'package:snake/core/models/game_state.dart';
import 'package:snake/features/game/widgets/game_area.dart';
import 'package:snake/core/constants/game_constants.dart';

class GameBoard extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onStartGame;
  final void Function(Direction) onDirectionChange;
  final void Function(int cols, int rows) onGridSizeChanged;
  const GameBoard({
    super.key,
    required this.gameState,
    required this.onStartGame,
    required this.onDirectionChange,
    required this.onGridSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //* Full size
        final double availW = constraints.maxWidth;
        final double availH = constraints.maxHeight;

        //* Fence size
        const double fenceSize = GameConstants.fenceSize;

        //* Interior size - space left after subtracting one fence tile on each side
        final double interiorW = availW - 2 * fenceSize;
        final double interiorH = availH - 2 * fenceSize;

        //* Find the largest square cell that fits the target grid in both axes
        final double targetCellW = interiorW / GameConstants.gridWidth;
        final double targetCellH = interiorH / GameConstants.gridHeight;
        final double cellSize = targetCellW < targetCellH
            ? targetCellW
            : targetCellH;

        //* How many whole cells actually fit
        final int cols = (interiorW / cellSize).floor();
        final int rows = (interiorH / cellSize).floor();

        //* Exact pixel size of the playable area
        final double boardW = cols * cellSize;
        final double boardH = rows * cellSize;

        //* Resize
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onGridSizeChanged(cols, rows);
        });

        return Center(
          child: GameArea(
            gameState: gameState,
            onStartGame: onStartGame,
            cellSize: cellSize,
            fenceSize: fenceSize,
            availW: availW,
            availH: availH,
            boardW: boardW,
            boardH: boardH,
          ),
        );
      },
    );
  }
}
