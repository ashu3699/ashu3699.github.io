import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../logic/logic.dart';

import 'painter.dart';

class AsteroidsApp extends StatefulWidget {
  const AsteroidsApp({super.key});

  @override
  State<AsteroidsApp> createState() => _AsteroidsAppState();
}

class _AsteroidsAppState extends State<AsteroidsApp> {
  @override
  void initState() {
    super.initState();
    startAnimation(setState);
    startTimer(setState);
    focusNode = FocusNode();
    focusNode.requestFocus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    size = MediaQuery.sizeOf(context);
    position = Offset(size.width / 2, size.height / 2);

    resetGame(setState);
  }

  @override
  void dispose() {
    focusNode.dispose();
    gameTimer.cancel();
    animationTimer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          if (isGameWon) {
            return gameWonView();
          } else if (isGameLost) {
            return gameLostView();
          } else {
            return gameView();
          }
        },
      ),
    );
  }

  Widget gameWonView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Score: $score',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'You Won!',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            'You lasted ${formatTime(timeElapsed)}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetGame(setState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  Widget gameLostView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Score: $score',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Game Over',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            'You lasted ${formatTime(timeElapsed)}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetGame(setState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget gameView() {
    return Stack(
      children: [
        MouseRegion(
          onHover: (event) {
            setState(() {
              player.updateDirection(event.position);
            });
          },
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                player.position = details.localPosition;
              });
            },
            child: Focus(
              autofocus: true,
              child: KeyboardListener(
                focusNode: focusNode,
                autofocus: true,
                onKeyEvent: (KeyEvent event) {
                  setState(() {
                    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                      player.rotate(-0.5);
                    } else if (event.logicalKey ==
                        LogicalKeyboardKey.arrowRight) {
                      player.rotate(0.5);
                    } else if (event.logicalKey == LogicalKeyboardKey.space) {
                      shoot(setState);
                    }

                    //move player with arrow keys
                    // if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                    //   player.position = Offset(player.position.dx,
                    //       player.position.dy - 10); //move up
                    // } else if (event.logicalKey ==
                    //     LogicalKeyboardKey.arrowDown) {
                    //   player.position = Offset(player.position.dx,
                    //       player.position.dy + 10); //move down
                    // } else if (event.logicalKey ==
                    //     LogicalKeyboardKey.arrowLeft) {
                    //   player.position = Offset(player.position.dx - 10,
                    //       player.position.dy); //move left
                    // } else if (event.logicalKey ==
                    //     LogicalKeyboardKey.arrowRight) {
                    //   player.position = Offset(player.position.dx + 10,
                    //       player.position.dy); //move right
                    // } else if (event.logicalKey == LogicalKeyboardKey.space) {
                    //   shoot(setState);
                    // }
                  });
                },
                child: CustomPaint(
                  painter: GamePainter(
                      player: player, particles: particles, bullets: bullets),
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Text(
            'Time: ${formatTime(timeElapsed)}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Text(
            'Score: $score',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
