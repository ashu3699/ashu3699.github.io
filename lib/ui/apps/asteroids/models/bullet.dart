import 'package:flutter/material.dart';

class Bullet {
  Offset position;
  Offset velocity;

  Bullet({required this.position, required this.velocity});

  void move() {
    position += velocity;
  }

  bool isOffScreen(Size screenSize) {
    return position.dx < 0 ||
        position.dx > screenSize.width ||
        position.dy < 0 ||
        position.dy > screenSize.height;
  }
}
