import 'package:flutter/material.dart';

import '../models/bullet.dart';
import '../models/particle.dart';
import '../models/player.dart';

class GamePainter extends CustomPainter {
  final Player player;
  final List<Particle> particles;
  final List<Bullet> bullets;

  GamePainter(
      {required this.player, required this.particles, required this.bullets});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    final cursorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    double cursorSize = 15;
    final path = Path()
      ..moveTo(-cursorSize, -cursorSize)
      ..lineTo(cursorSize, -cursorSize)
      ..lineTo(0, cursorSize)
      ..close();

    canvas.save();
    canvas.translate(player.position.dx, player.position.dy);
    canvas.rotate(player.direction);
    canvas.drawPath(path, cursorPaint);
    canvas.restore();

    paint.color = Colors.red;
    for (var particle in particles) {
      canvas.drawCircle(particle.position, particle.size, paint);
    }

    paint.color = Colors.yellow;
    for (var bullet in bullets) {
      canvas.drawCircle(bullet.position, 5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
