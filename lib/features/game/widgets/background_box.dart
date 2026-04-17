import 'package:flutter/material.dart';

class BackgroundBox extends StatelessWidget {
  final Widget child;
  const BackgroundBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cs.secondaryContainer.withValues(alpha: 0.3),
        ),
        child: Padding(padding: EdgeInsets.all(8), child: child),
      ),
    );
  }
}
