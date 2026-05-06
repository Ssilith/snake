import 'package:flutter/material.dart';
import 'package:snake/features/game/widgets/image_position.dart';
import 'package:snake/core/services/asset_helper.dart';

class FenceUtils {
  //* Count of tiles and its size
  static (int, double) tileFit(double length, double fenceSize) {
    final int count = (length / fenceSize).floor().clamp(1, 999);
    return (count, length / count);
  }

  static List<Widget> buildTopRow(
    double left,
    double y,
    double right,
    double fenceSize,
  ) {
    final double stripW = right - left - fenceSize;
    final (int count, double tileW) = tileFit(stripW, fenceSize);
    return [
      //* Horizontal
      for (int i = 0; i < count; i++)
        ImagePosition(
          left: left + fenceSize + i * tileW,
          top: y,
          width: tileW,
          height: fenceSize,
          asset: AssetHelper.getFenceAsset(
            isTopEdge: true,
            isBottomEdge: false,
            isLeftEdge: false,
            isRightEdge: false,
          ),
        ),
      //* Top left corner
      ImagePosition(
        left: left,
        top: y,
        width: fenceSize,
        height: fenceSize,
        asset: AssetHelper.getFenceAsset(
          isTopEdge: true,
          isBottomEdge: false,
          isLeftEdge: true,
          isRightEdge: false,
        ),
      ),
      //* Top right corner
      ImagePosition(
        left: right,
        top: y,
        width: fenceSize,
        height: fenceSize,
        asset: AssetHelper.getFenceAsset(
          isTopEdge: true,
          isBottomEdge: false,
          isLeftEdge: false,
          isRightEdge: true,
        ),
      ),
    ];
  }

  static List<Widget> buildBottomRow(
    double left,
    double y,
    double right,
    double fenceSize,
  ) {
    final double stripW = right - left - fenceSize;
    final (int count, double tileW) = tileFit(stripW, fenceSize);
    return [
      //* Horizontal
      for (int i = 0; i < count; i++)
        ImagePosition(
          left: left + fenceSize + i * tileW,
          top: y,
          width: tileW,
          height: fenceSize,
          asset: AssetHelper.getFenceAsset(
            isTopEdge: false,
            isBottomEdge: true,
            isLeftEdge: false,
            isRightEdge: false,
          ),
        ),
      //* Bottom left corner
      ImagePosition(
        left: left,
        top: y,
        width: fenceSize,
        height: fenceSize,
        asset: AssetHelper.getFenceAsset(
          isTopEdge: false,
          isBottomEdge: true,
          isLeftEdge: true,
          isRightEdge: false,
        ),
      ),
      //* Bottom right corner
      ImagePosition(
        left: right,
        top: y,
        width: fenceSize,
        height: fenceSize,
        asset: AssetHelper.getFenceAsset(
          isTopEdge: false,
          isBottomEdge: true,
          isLeftEdge: false,
          isRightEdge: true,
        ),
      ),
    ];
  }

  static List<Widget> buildLeftCol(
    double x,
    double top,
    double bottom,
    double fenceSize,
  ) {
    final double stripH = bottom - top - fenceSize;
    final (int count, double tileH) = tileFit(stripH, fenceSize);
    return [
      //* Vertical
      for (int i = 0; i < count; i++)
        ImagePosition(
          left: x,
          top: top + fenceSize + i * tileH,
          width: fenceSize,
          height: tileH,
          asset: AssetHelper.getFenceAsset(
            isTopEdge: false,
            isBottomEdge: false,
            isLeftEdge: true,
            isRightEdge: false,
          ),
        ),
    ];
  }

  static List<Widget> buildRightCol(
    double x,
    double top,
    double bottom,
    double fenceSize,
  ) {
    final double stripH = bottom - top - fenceSize;
    final (int count, double tileH) = tileFit(stripH, fenceSize);
    return [
      //* Vertical
      for (int i = 0; i < count; i++)
        ImagePosition(
          left: x,
          top: top + fenceSize + i * tileH,
          width: fenceSize,
          height: tileH,
          asset: AssetHelper.getFenceAsset(
            isTopEdge: false,
            isBottomEdge: false,
            isLeftEdge: false,
            isRightEdge: true,
          ),
        ),
    ];
  }
}
