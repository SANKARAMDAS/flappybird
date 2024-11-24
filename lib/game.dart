import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybird/components/pipe_manager.dart';
import 'package:flutter/material.dart';

import 'components/background.dart';
import 'components/bird.dart';
import 'components/ground.dart';
import 'components/pipe.dart';
import 'components/score.dart';
import 'constants.dart';

class FlappyBird extends FlameGame with TapDetector, HasCollisionDetection {
  /*
    - Bird
    - Background
    - Ground
    - Pipes
    - Score
   */

  late Bird bird; 
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  /*

   LOAD
   
  */

  @override
  FutureOr<void> onLoad() {
    //load background
    background = Background(size);
    add(background);

    // load Bird
    bird = Bird();
    add(bird);

    // load ground
    ground = Ground();
    add(ground);

    //load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    //load score
    scoreText = ScoreText();
    add(scoreText);
  }

  /*

    TAP

   */

  @override
  void onTap() {
    // TODO: implement onTap
    bird.flap();
  }

  /*
    

     SCORE

   */

  int score = 0;

  void incrementScore() {
    score += 1;
  }

  /*
  
   GAME OVER
  
   */

  bool isGameOver = false;

  void gameOver() {
    //prevent multiple game over trigger
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    //show dialog box  for user
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        actions: [
          TextButton(
            onPressed: () {
              //pop box
              Navigator.pop(context);

              //rest game
              resetGame();
            },
            child: const Text('Restart'),
          )
        ],
      ),
    );
  }

  void resetGame() {
    //reset game state
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    //REMOVE ALL PIPES FROM THE GAME
    children.whereType<Pipe>().forEach(
          (Pipe pipe) => pipe.removeFromParent(),
        );
    resumeEngine();
  }
}
