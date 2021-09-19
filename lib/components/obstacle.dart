import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class ObstacleTile extends SpriteComponent with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  

  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 = await Sprite.load('Tiles/inv_obs.png', srcSize: Vector2(287, 177));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    this.addShape(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if(other is RedHood){
      // print('redhood');
    }
  }

  
}