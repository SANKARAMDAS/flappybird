import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappybird/game.dart';

import '../constants.dart';
import 'pipe.dart';

class PipeManager extends Component with HasGameRef<FlappyBird> {
  /*
  
    UPDATE -> every second (dt)

    we will continuously spawn new pipe 

   */

  double pipeSpawnTime = 0;

  @override
  void update(double dt) {
    // TODO: implement update
    pipeSpawnTime += dt;
    

    if (pipeSpawnTime > pipeInterval) {
      pipeSpawnTime = 0;
      spawnPipe();
    }
  }

  /*
  
   SPAWN NEW PIPES

   */

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    

    /*
    
     CALCULATE PIPE HEIGHT
    
     */

    //max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    //height of bottom pipe => randomly select between min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    //height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    /*
        
           CREATE BOTTOM PIPE
        
         */

    final bottomPipe = Pipe(
      //position
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      //size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    /*
    
      CREATE TOP PIPE
    
     */

    final topPipe = Pipe(
      //position
      Vector2(gameRef.size.x, 0),
      //size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );


    //add both pipes to the game
    gameRef.add(bottomPipe);  
    gameRef.add(topPipe);
  }
}
