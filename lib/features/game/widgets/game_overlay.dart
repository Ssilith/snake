import 'package:flutter/material.dart';
import 'package:snake/features/game/widgets/background_box.dart';
import 'package:snake/features/drawer/widgets/game_button.dart';

class GameOverlay extends StatelessWidget {
  final IconData titleIconData;
  final String title;
  final IconData subtitleIconData;
  final String subtitle;
  final String? buttonTitle;
  final VoidCallback? onButtonTap;
  const GameOverlay({
    super.key,
    required this.titleIconData,
    required this.title,
    required this.subtitleIconData,
    required this.subtitle,
    this.buttonTitle,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return BackgroundBox(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.primaryContainer),
            boxShadow: kElevationToShadow[8],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(titleIconData, color: cs.primary, size: 64),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      subtitleIconData,
                      size: 18,
                      color: cs.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (buttonTitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GameButton(
                    iconData: Icons.replay_rounded,
                    onTap: onButtonTap!,
                    title: buttonTitle!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
