import 'package:flutter/material.dart';
import 'package:inner_glow/inner_glow.dart';
import 'package:snake/core/constants/game_constants.dart';

class BoardGradient extends StatelessWidget {
  final double availW;
  final double availH;
  final Widget child;
  const BoardGradient({
    super.key,
    required this.availW,
    required this.availH,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InnerGlow(
        width: availW,
        height: availH,
        thickness: 120,
        glowBlur: 40,
        blurBackground: 80,
        glowRadius: 8,
        strokeLinearGradient: const LinearGradient(
          colors: [
            Color(GameConstants.fenceColor),
            Color(GameConstants.fenceColor),
          ],
        ),
        baseDecoration: BoxDecoration(
          color: const Color(GameConstants.boardColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
