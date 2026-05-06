import 'package:flutter/material.dart';

class SnakeLoader extends StatelessWidget {
  final double progress;
  const SnakeLoader({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final prog = progress.clamp(0.0, 1.0);
    final isDone = prog >= 0.999;
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        const headSize = 18.0;
        const appleSize = 36.0;
        const trackHeight = 10.0;

        final width = constraints.maxWidth;
        final height = appleSize > headSize ? appleSize : headSize;

        //* Start position
        final start = headSize;

        //* Define apple center and end
        final appleCenterX = width - appleSize / 2;
        final appleEndX = appleCenterX + appleSize / 2;

        //* End position
        final end = appleEndX;

        //* Define snake body and head position
        final bodyWidth = (end - start) * prog;
        final headX = start + bodyWidth;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  //* Track
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: start),
                    height: trackHeight,
                    decoration: BoxDecoration(
                      color: cs.surfaceContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  //* Body
                  Positioned(
                    left: start,
                    child: Container(
                      width: bodyWidth,
                      height: trackHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightGreenAccent, Colors.green],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  //* Head
                  Positioned(
                    left: headX - headSize,
                    child: Container(
                      width: headSize,
                      height: headSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  //* Apple
                  if (!isDone)
                    Positioned(
                      left: appleCenterX - appleSize / 2,
                      child: Icon(
                        Icons.apple,
                        size: appleSize,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
