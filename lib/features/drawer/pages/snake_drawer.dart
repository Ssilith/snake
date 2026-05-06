import 'package:flutter/material.dart';
import 'package:snake/core/models/game_state.dart';
import 'package:snake/features/drawer/widgets/drawer_title.dart';
import 'package:snake/features/drawer/widgets/game_button.dart';
import 'package:snake/features/drawer/widgets/game_info_item.dart';
import 'package:snake/features/drawer/widgets/game_info_title.dart';
import 'package:snake/features/drawer/widgets/game_status_indicator.dart';
import 'package:snake/features/drawer/widgets/pause_button.dart';
import 'package:snake/features/drawer/widgets/statistics_card.dart';
import 'package:snake/core/constants/game_constants.dart';
import 'package:snake/core/utils/game_utils.dart';

class SnakeDrawer extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onStartGame;
  final VoidCallback onTogglePause;
  const SnakeDrawer({
    super.key,
    required this.gameState,
    required this.onStartGame,
    required this.onTogglePause,
  });

  //* Get level label
  String get _levelLabel {
    return 'Lvl ${GameUtils.calculateLevel(gameState.gameSpeed)}';
  }

  //* Divider decoration
  Widget _divider() {
    return const Padding(padding: EdgeInsetsGeometry.all(5), child: Divider());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: GameConstants.drawerWidth,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: size.height - 40,
          child: Column(
            children: [
              //* Title
              const DrawerTitle(title: "SNAKE"),
              _divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //* Total Score
                      StatisticsCard(
                        title: 'Score',
                        color: cs.primary,
                        icon: Icons.stars_rounded,
                        value: '${gameState.score}',
                      ),
                      _divider(),
                      //* Start / Restart button
                      SizedBox(
                        width: double.maxFinite,
                        child: GameButton(
                          onTap: onStartGame,
                          title: gameState.hasStarted
                              ? 'RESTART'
                              : 'START GAME',
                          iconData: gameState.hasStarted
                              ? Icons.refresh_rounded
                              : Icons.play_arrow_rounded,
                        ),
                      ),
                      const SizedBox(height: 8),
                      //* Pause button
                      PauseButton(
                        gameState: gameState,
                        onTogglePause: onTogglePause,
                      ),
                      _divider(),
                      //* Game Info
                      GameInfoTitle(
                        iconData: Icons.info_rounded,
                        title: 'GAME INFO',
                        items: [
                          GameInfoItem(
                            icon: Icons.speed_rounded,
                            title: 'Speed',
                            value: _levelLabel,
                          ),
                          GameInfoItem(
                            icon: Icons.straighten_rounded,
                            title: 'Length',
                            value: '${gameState.snake.length}',
                          ),
                          GameInfoItem(
                            icon: Icons.apple_rounded,
                            title: 'Apples',
                            value: '${gameState.applesCollected}',
                          ),
                        ],
                      ),
                      _divider(),
                      //* Controls
                      const GameInfoTitle(
                        iconData: Icons.gamepad_rounded,
                        title: 'CONTROLS',
                        items: [
                          GameInfoItem(
                            icon: Icons.keyboard,
                            title: 'Arrow Keys / WASD',
                          ),
                          GameInfoItem(
                            icon: Icons.keyboard_return,
                            title: 'Enter to start game',
                          ),
                          GameInfoItem(
                            icon: Icons.pause_circle_outline,
                            title: 'Space to pause / resume',
                          ),
                          GameInfoItem(
                            icon: Icons.apple,
                            title: 'Collect apples',
                          ),
                          GameInfoItem(
                            icon: Icons.warning_amber_rounded,
                            title: 'Avoid walls',
                          ),
                        ],
                      ),
                      _divider(),
                    ],
                  ),
                ),
              ),
              //* Status
              GameStatusIndicator(gameState: gameState),
            ],
          ),
        ),
      ),
    );
  }
}
