import 'package:flutter/material.dart';

class GameInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  const GameInfoItem({
    super.key,
    required this.icon,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: cs.primary.withValues(alpha: 0.7)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          if (value != null)
            Text(
              value!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.primary,
              ),
            ),
        ],
      ),
    );
  }
}
