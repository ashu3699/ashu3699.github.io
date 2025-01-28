import 'dart:math';
import 'dart:ui';

class Player {
  Offset position;
  double direction;

  Player({required this.position, this.direction = 0});

  void rotate(double angle) {
    direction += angle;
  }

  void updateDirection(Offset mousePosition) {
    direction =
        atan2(mousePosition.dy - position.dy, mousePosition.dx - position.dx);
    position = mousePosition;
  }
}
