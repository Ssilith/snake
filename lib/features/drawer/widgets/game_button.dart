import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  const GameButton({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(iconData),
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
