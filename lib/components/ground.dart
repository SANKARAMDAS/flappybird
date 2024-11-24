import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../constants.dart';
import '../game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBird>, CollisionCallbacks {
  //init
  Ground() : super();

  /*
  
    LOAD

   */

  @override
  FutureOr<void> onLoad() async {
    // set size and position
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight); //0, 0

    //load the sprite image
    sprite = await Sprite.load('base.png');

    //add a collision box
    add(RectangleHitbox());
  }

  /*
    
    UPDATE => EVERY SECOND (dt)
   
    */

  @override
  void update(double dt) {
    //save ground to left
    position.x -= groundScrollingSpeed * dt;

    //reset ground if it goes off screen for infinite scroll
    //if half of the ground has been passed, reset
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
