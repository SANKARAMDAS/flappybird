import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappybird/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBird> {
  //init
  ScoreText() : super(text: '0',
  textRenderer: TextPaint(
    style: TextStyle(
      color: Colors.black,
      fontSize: 40,
    ),
  ),);

  //land
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    position = Vector2(
      //center horizonally
      (gameRef.size.x - size.x) / 2,
      //slightly above the bottom
      (gameRef.size.y - size.y - 50),
    );
  }

  //update
  @override
  void update(double dt) {
    // TODO: implement update
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText; 
    }
  }
}
