import 'package:flutter/material.dart';

class DrawerTitle extends StatelessWidget {
  final String title;
  const DrawerTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.only(top: 12),
      alignment: Alignment.center,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: cs.primary,
        ),
      ),
    );
  }
}
