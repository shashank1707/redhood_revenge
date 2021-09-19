import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Warrior extends SpriteAnimationComponent{

  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation;
  late SpriteAnimation hurtAnimation;


  @override
  Future<void> onLoad() async {
    final idleImage = await Flame.images.load('Heros/redhood/redhood_idle.png');
    final runImage = await Flame.images.load('Heros/redhood/redhood_run.png');
    final jumpImage = await Flame.images.load('Heros/redhood/redhood_jump.png');
    final attackImage = await Flame.images.load('Heros/redhood/redhood_attack.png');
    final hurtImage = await Flame.images.load('Heros/redhood/redhood_hurt.png');

    final idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 0, to: 18);
    final runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 0, to: 24);
    final jumpAnimation = SpriteSheet(image: jumpImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 0, to: 19);
    final attackAnimation1 = SpriteSheet(image: attackImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 5, to: 14);
    final attackAnimation2 = SpriteSheet(image: attackImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 14, to: 25);
    final hurtAnimation = SpriteSheet(image: hurtImage, srcSize: Vector2(80, 80)).createAnimation(row: 0, stepTime: 0.05, from: 0, to: 7);

    this.animation = attackAnimation1;
    this.anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = this.width = gameSize.x/5;
    // this.x = this.width/2;
    // this.y = gameSize.y - this.height/2; 

    this.x = gameSize.x + 200;
    this.y = gameSize.y - this.height/2; 
  }
}