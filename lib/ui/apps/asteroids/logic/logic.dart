import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/bullet.dart';
import '../models/particle.dart';
import '../models/player.dart';

FocusNode focusNode = FocusNode();
bool isGameLost = false, isGameWon = false;
int shootingSpeed = 10, timeElapsed = 0, score = 0;

List<Particle> particles = [];
List<Bullet> bullets = [];

late Timer gameTimer;
late Timer animationTimer;
late Size size;
late Offset position;
late Player player;

void resetGame(setState) {
  setState(() {
    player = Player(position: position);

    particles = generateParticles(
      count: 5,
      screenSize: size,
      playerPosition: player.position,
      safeDistance: 50,
      minSize: 10,
      maxSize: 15,
      minVelocity: 0.5,
      maxVelocity: 2,
    );
    bullets.clear();
    timeElapsed = 0;
    score = 0;
    isGameLost = false;
    isGameWon = false;

    if (gameTimer.isActive) {
      gameTimer.cancel();
    }

    focusNode.requestFocus();

    startTimer(setState);
  });
}

void startAnimation(setState) {
  animationTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
    setState(() {
      moveParticlesAndBullets(setState);
    });
  });
}

void moveParticlesAndBullets(setState) {
  List<Particle> particlesToRemove = [];
  List<Bullet> bulletsToRemove = [];

  for (var particle in particles) {
    particle.move(size);
    if (particle.collidesWithPlayer(player)) {
      gameLost(setState);
      return;
    }
  }

  for (var bullet in bullets) {
    bullet.move();
    if (bullet.isOffScreen(size)) {
      bulletsToRemove.add(bullet);
    }
  }

  for (var bullet in bullets) {
    particles.removeWhere((particle) {
      if (particle.collidesWithBullet(bullet)) {
        score++;
        particlesToRemove.add(particle);
        return true;
      }
      return false;
    });
  }

  setState(() {
    particles.removeWhere((particle) => particlesToRemove.contains(particle));
    bullets.removeWhere((bullet) => bulletsToRemove.contains(bullet));

    if (particles.isEmpty) {
      gameWon(setState);
    }
  });
}

void gameLost(setState) {
  setState(() {
    isGameLost = true;

    if (gameTimer.isActive) {
      gameTimer.cancel();
    }
  });
}

void gameWon(setState) {
  setState(() {
    isGameWon = true;

    if (gameTimer.isActive) {
      gameTimer.cancel();
    }
  });
}

void startTimer(setState) {
  gameTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) {
      setState(() {
        timeElapsed++;
        updateParticles(setState);
        updateBullets(setState);
      });
    },
  );
}

void updateParticles(setState) {
  setState(() {
    for (var particle in particles) {
      particle.position += particle.velocity;

      if (particle.position.dx < 0 || particle.position.dx > size.width) {
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height) {
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }
    }
  });
}

void updateBullets(setState) {
  List<Bullet> bulletsToRemove = [];

  for (var bullet in bullets) {
    bullet.move();
    if (bullet.isOffScreen(size)) {
      bulletsToRemove.add(bullet);
    }
  }

  setState(() {
    bullets.removeWhere((bullet) => bulletsToRemove.contains(bullet));
  });
}

void shoot(setState) {
  final velocity = Offset(
    shootingSpeed * cos(player.direction),
    shootingSpeed * sin(player.direction),
  );

  setState(() {
    bullets.add(Bullet(position: player.position, velocity: velocity));
  });
}
