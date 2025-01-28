import 'dart:math';

import 'package:flutter/material.dart';

import 'bullet.dart';
import 'player.dart';

class Particle {
  Offset position;
  Offset velocity;
  double size;

  Particle(
      {required this.position, required this.velocity, required this.size});

  void move(Size screenSize) {
    position += velocity;

    if (position.dx < 0) {
      position = Offset(screenSize.width, position.dy);
    } else if (position.dx > screenSize.width) {
      position = Offset(0, position.dy);
    }

    if (position.dy < 0) {
      position = Offset(position.dx, screenSize.height);
    } else if (position.dy > screenSize.height) {
      position = Offset(position.dx, 0);
    }
  }

  bool collidesWithPlayer(Player player) {
    return (position - player.position).distance < (size + 20);
  }

  bool collidesWithBullet(Bullet bullet) {
    return (position - bullet.position).distance < size;
  }
}

List<Particle> generateParticles(
    {required int count,
    required Size screenSize,
    required Offset playerPosition,
    required double safeDistance,
    required double minSize,
    required double maxSize,
    required double minVelocity,
    required double maxVelocity}) {
  List<Particle> particles = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    Offset position;
    double size = minSize + random.nextDouble() * (maxSize - minSize);
    Offset velocity = Offset(
      minVelocity + random.nextDouble() * (maxVelocity - minVelocity),
      minVelocity + random.nextDouble() * (maxVelocity - minVelocity),
    );

    do {
      position = Offset(
        random.nextDouble() * screenSize.width,
        random.nextDouble() * screenSize.height,
      );
    } while ((position - playerPosition).distance < size + safeDistance);

    particles.add(Particle(position: position, velocity: velocity, size: size));
  }

  return particles;
}
