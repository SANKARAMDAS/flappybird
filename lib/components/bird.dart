import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappybird/components/ground.dart';
import 'package:flappybird/game.dart';

import '../constants.dart';
import 'pipe.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*
     INIT BIRD
   */

  //Initialise bird position & size
  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdWidth, birdHeight));

  //physical world properties
  double velocity = 0;

  /*
     LOAD
    */

  @override
  FutureOr<void> onLoad() async {
    // TODO: implement onLoad
    sprite = await Sprite.load('bird.png');

    //add hit box
    add(
      RectangleHitbox(),
    );
  }

  /*
    JUMP /FLAP
   */

  void flap() {
    velocity = jumpStrength;
  }

  /*
    UPDATE -> EVERY SECOND
   */

  @override
  void update(double dt) {
    // TODO: implement update
    velocity += gravity * dt;

    //update bird's position based on current velocity
    position.y += velocity * dt;
  }

  /*
  
    COLLISION -> with another object
  
   */

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    //check if bird collides with ground
    if (other is Ground) {
      (parent as FlappyBird).gameOver();
    }


    //bird collides with the pipes
    if(other is Pipe){
      (parent as FlappyBird).gameOver();
    }
  }
}
