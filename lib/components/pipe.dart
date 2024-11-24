import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappybird/constants.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlameGame> {
  //determine if pipe is top or bottom
  final bool isTopPipe;

  //score
  bool scored = false;

  //init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  /*
  
    LOAD

   */

  @override
  FutureOr<void> onLoad() async {
    // load sprite image
    sprite = await Sprite.load(isTopPipe ? 'down_piler.png' : 'up_piler.png');

    //add hit box for collision
    add(
      RectangleHitbox(),
    );
  }

  /*
  
   UPDATE
  
   */

  @override
  void update(double dt) {
    // scroll pipe to left
    position.x -= groundScrollingSpeed * dt;

    //check if the bird has passed this pipe
    if (!scored && position.x + size.x < gameRef.priority) {
      scored = true;

      //only increment for top pipes to avoid double counting
      if (isTopPipe) {
        // gameRef.incrementScore();
      }
    }

    //remove pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
