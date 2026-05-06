class SnakeSegment {
  final int x;
  final int y;

  const SnakeSegment(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is SnakeSegment && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}
