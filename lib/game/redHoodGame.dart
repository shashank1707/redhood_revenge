import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/backgrounds/dayBack.dart';
import 'package:red_hood_revenge/backgrounds/nightBack.dart';
import 'package:red_hood_revenge/characters/enemy.dart';
import 'package:red_hood_revenge/characters/fakeHero.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/characters/warrior.dart';
import 'package:red_hood_revenge/components/flatTile.dart';
import 'package:red_hood_revenge/components/obstacle.dart';

class RedHoodGame extends BaseGame with TapDetector, HasCollidables {

  bool visible = false;

  late ParallaxComponent nightParallax;
  late RedHood redHoodComponent;
  // late FakeRedHood fakeRedHoodComponent;

  late Vector2 parallaxVelocity = Vector2(0, 0);
  
  late FlatTile baseTile;

  @override
  Future<void> onLoad() async {
    
    redHoodComponent = RedHood();
    nightParallax = await loadParallaxComponent([
      ParallaxImageData('parallax_night/SET1_bakcground_night1.png'),
      ParallaxImageData('parallax_night/SET1_bakcground_night2.png'),
      ParallaxImageData('parallax_night/SET1_bakcground_night3.png'),
    ],
    velocityMultiplierDelta: Vector2(1.4, 0)
    );
    add(nightParallax);
    add(redHoodComponent);

    baseTile = FlatTile();

    baseTile.x = 0;
    baseTile.y = canvasSize.y/2 ;
    add(baseTile);

    camera.followComponent(redHoodComponent);

    final enemy = Enemy(EnemyType.Eye);
    enemy.x = redHoodComponent.x + 350; enemy.y = canvasSize.y/2;
    add(enemy);

    final enemy2 = Enemy(EnemyType.Goblin);
    enemy2.x = redHoodComponent.x + 950; enemy2.y = canvasSize.y/2;
    add(enemy2);

    final enemy3 = Enemy(EnemyType.Skeleton);
    enemy3.x = redHoodComponent.x + 1550; enemy3.y = canvasSize.y/2;
    add(enemy3);

    

    this.visible = true;
  }

  @override
  void render(Canvas canvas) async {
    if(this.visible){
      super.render(canvas);
    }
    
  }

  @override
  void update(double dt) {
    super.update(dt);
    
  }

  



}