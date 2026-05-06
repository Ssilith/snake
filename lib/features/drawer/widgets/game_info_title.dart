import 'package:flutter/material.dart';
import 'package:snake/features/drawer/widgets/game_info_item.dart';

class GameInfoTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final List<GameInfoItem> items;
  const GameInfoTitle({
    super.key,
    required this.iconData,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cs.secondaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(iconData, color: cs.secondary, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: cs.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }
}
