import 'package:flutter/material.dart';
import 'package:snake/core/services/game_assets.dart';
import 'package:snake/widgets/snake_loader.dart';

class ImagePreloader extends StatefulWidget {
  final Widget child;
  const ImagePreloader({super.key, required this.child});

  @override
  State<ImagePreloader> createState() => _ImagePreloaderState();
}

class _ImagePreloaderState extends State<ImagePreloader> {
  bool _isDone = false;
  int _loadedAssets = 0;
  final _assets = GameAssets.getAllAssets();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDone) _preload();
  }

  Future<void> _preload() async {
    for (int i = 0; i < _assets.length; i++) {
      await precacheImage(_assets[i], context);
      setState(() => _loadedAssets = i + 1);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isDone = true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!_isDone) {
      final percentage = _assets.isEmpty ? 0.0 : _loadedAssets / _assets.length;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 300, child: SnakeLoader(progress: percentage)),
            const SizedBox(height: 20),
            Text(
              'Loading... ${(_loadedAssets)}/${_assets.length}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
    return widget.child;
  }
}
