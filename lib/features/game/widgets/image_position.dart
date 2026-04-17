import 'package:flutter/material.dart';

class ImagePosition extends StatelessWidget {
  final double left;
  final double top;
  final double width;
  final double height;
  final AssetImage? asset;
  const ImagePosition({
    super.key,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    if (asset == null) return const SizedBox.shrink();
    return Positioned(
      left: left,
      top: top,
      child: Image(
        image: asset!,
        width: width,
        height: height,
        fit: BoxFit.fill,
      ),
    );
  }
}
