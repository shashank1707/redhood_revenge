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
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class FlatTile extends SpriteComponent with HasGameRef<RedHoodGame>, Hitbox, Collidable {

  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 = await Sprite.load('baseTile.png', srcSize: Vector2(4014, 149));
    this.sprite = sprite1;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());
    addObstacles();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 4014;
    // this.y = gameSize.y/2 + this.height - 10;
    // this.x = 0;

  }

  void addObstacles(){

    final tileY = gameRef.canvasSize.y/2 + gameRef.baseTile.height/2;

    final ob1 = ObstacleTile(); ob1.height = gameRef.baseTile.height; ob1.width = 1; ob1.x = 535; ob1.y = tileY - ob1.height; gameRef.add(ob1);

    final ob2 = ObstacleTile(); ob2.height = gameRef.baseTile.height/2; ob2.width = 120; ob2.x = 900; ob2.y = tileY - ob2.height; gameRef.add(ob2);

    final ob3 = ObstacleTile(); ob3.height = 3*gameRef.baseTile.height/4; ob3.width = 50; ob3.x = 1080; ob3.y = tileY - ob3.height; gameRef.add(ob3);

    final ob4 = ObstacleTile(); ob4.height = gameRef.baseTile.height; ob4.width = 30; ob4.x = 1150; ob4.y = tileY - ob4.height; gameRef.add(ob4);

    final ob5 = ObstacleTile(); ob5.height = gameRef.baseTile.height/2; ob5.width = 35; ob5.x = 1270; ob5.y = tileY - ob5.height; gameRef.add(ob5);

    final ob6 = ObstacleTile(); ob6.height = gameRef.baseTile.height/2; ob6.width = 120; ob6.x = 1570; ob6.y = tileY - ob6.height; gameRef.add(ob6);

    final ob7 = ObstacleTile(); ob7.height = 2*gameRef.baseTile.height/5; ob7.width = 30; ob7.x = 1430; ob7.y = tileY - ob7.height; gameRef.add(ob7);

    final ob7_1 = ObstacleTile(); ob7_1.height = 2*gameRef.baseTile.height/5; ob7_1.width = 30; ob7_1.x = 2015; ob7_1.y = tileY - ob7_1.height; gameRef.add(ob7_1);

    final ob8 = ObstacleTile(); ob8.height = gameRef.baseTile.height/2; ob8.width = 100; ob8.x = 2170; ob8.y = tileY - ob8.height; gameRef.add(ob8);

    final ob9 = ObstacleTile(); ob9.height = 3*gameRef.baseTile.height/4; ob9.width = 170; ob9.x = 2330; ob9.y = tileY - ob9.height; gameRef.add(ob9);

    final ob10 = ObstacleTile(); ob10.height = gameRef.baseTile.height; ob10.width = 30; ob10.x = 2395; ob10.y = tileY - ob10.height; gameRef.add(ob10);

    final ob11 = ObstacleTile(); ob11.height = gameRef.baseTile.height/2; ob11.width = 60; ob11.x = 2535; ob11.y = tileY - ob11.height; gameRef.add(ob11);

    final ob12 = ObstacleTile(); ob12.height = gameRef.baseTile.height/2; ob12.width = 160; ob12.x = 3140; ob12.y = tileY - ob12.height; gameRef.add(ob12);

    final ob13 = ObstacleTile(); ob13.height = 3*gameRef.baseTile.height/4; ob13.width = 40; ob13.x = 3240; ob13.y = tileY - ob13.height; gameRef.add(ob13);

    final ob14 = ObstacleTile(); ob14.height = 2*gameRef.baseTile.height; ob14.width = 30; ob14.x = 3305; ob14.y = tileY - ob14.height; gameRef.add(ob14);

  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    
  }

  
}