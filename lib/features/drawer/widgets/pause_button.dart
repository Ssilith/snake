import 'package:flutter/material.dart';
import 'package:snake/core/models/game_state.dart';

class PauseButton extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onTogglePause;
  const PauseButton({
    super.key,
    required this.gameState,
    required this.onTogglePause,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bool canPause = gameState.isPlaying;
    final bool isPaused = gameState.isPaused;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: canPause || isPaused ? onTogglePause : null,
        icon: Icon(
          isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
          size: 20,
        ),
        label: Text(
          isPaused ? 'RESUME' : 'PAUSE',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(
            color: canPause || isPaused
                ? cs.primary.withValues(alpha: 0.6)
                : cs.outline.withValues(alpha: 0.3),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
