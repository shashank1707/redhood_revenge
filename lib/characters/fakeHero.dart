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
import 'package:red_hood_revenge/components/flatTile.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class RedHoodFake extends SpriteAnimationComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation1;
  late SpriteAnimation attackAnimation2;
  late SpriteAnimation hurtAnimation;

  late double heroSpeedX = 0;
  late double heroSpeedY = 0;
  late double yMax = 0;
  late double yCenter = 0;
  late double gravity = 1000;
  late bool attackAnim = true;
  late bool isAttacking = false;
  late bool isRunning = false;
  late bool isJumping = false;
  late bool inAir = false;
  late Timer _timer;
  late Timer _timer2;

  Vector2 hitBox = Vector2(40, 40);

  @override
  Future<void> onLoad() async {
    debugMode = true;

    final idleImage = await Flame.images.load('Heros/redhood/redhood_idle.png');
    final runImage = await Flame.images.load('Heros/redhood/redhood_run.png');
    final jumpImage = await Flame.images.load('Heros/redhood/redhood_jump.png');
    final attackImage =
        await Flame.images.load('Heros/redhood/redhood_attack.png');
    final hurtImage = await Flame.images.load('Heros/redhood/redhood_hurt.png');

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 18);
    runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.025, from: 0, to: 24);
    jumpAnimation = SpriteSheet(image: jumpImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.075, from: 0, to: 19);
    attackAnimation1 = SpriteSheet(image: attackImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.05, from: 7, to: 14);
    attackAnimation2 = SpriteSheet(image: attackImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.05, from: 15, to: 24);
    hurtAnimation = SpriteSheet(image: hurtImage, srcSize: Vector2(80, 80))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 7);

    this.animation = idleAnimation;
    this.anchor = Anchor.center;

    _timer = Timer(0.4, callback: () {
      this.animation = idleAnimation;
      this.isAttacking = false;
    });

    var shape = HitboxPolygon([
      Vector2(-0.5, -0.5),
      Vector2(0.5, -0.5),
      Vector2(0.5, 0.5),
      Vector2(-0.5, 0.5),
    ]);

    this.addShape(shape);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = this.width = gameSize.x / 5;
    this.x = 700;
    gameRef.nightParallax.x = 700 - gameSize.x / 2;
    this.y = gameRef.canvasSize.y / 2;
    this.yMax = this.y;
    this.yCenter = this.y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x += heroSpeedX * dt;

    gameRef.nightParallax.x += heroSpeedX * dt;
    gameRef.nightParallax.parallax!.baseVelocity.x = heroSpeedX * dt * 10;

    // v = u + at;
    this.heroSpeedY += gravity * dt;

    // d = si + s * t
    this.y += this.heroSpeedY * dt;
    gameRef.nightParallax.y += this.heroSpeedY * dt;

    if (isOnGround()) {
      this.y = this.yMax;
      this.heroSpeedY = 0;
      gameRef.nightParallax.y = 0;
      this.isJumping = false;
    }

    if (isOnGround() && !this.isRunning && !this.isAttacking) {
      this.stopMoving();
    }

    if (!this.isJumping && this.isRunning && !this.isAttacking) {
      this.animation = runAnimation;
    }

    _timer.update(dt);
  }

  void moveForward() {
    this.renderFlipX = false;
    if (!this.isJumping) {
      this.animation = runAnimation;
    }
    this.heroSpeedX = 500;
    isRunning = true;
  }

  void moveBackward() {
    this.renderFlipX = true;
    if (!this.isJumping) {
      this.animation = runAnimation;
    }
    this.heroSpeedX = -500;
    isRunning = true;
  }

  void stopMoving() {
    this.animation = idleAnimation;
    this.isAttacking = false;
    this.heroSpeedX = 0;
    this.isRunning = false;
    this.isJumping = false;
  }

  void attack() {
    if (!this.isAttacking) {
      if (this.attackAnim) {
        this.animation = attackAnimation1;
      } else {
        this.animation = attackAnimation2;
      }
      this.attackAnim = !this.attackAnim;
      _timer.start();
      this.isAttacking = true;
    }
  }

  bool isOnGround() {
    if (this.y >= this.yMax) {
      return true;
    } else {
      return false;
    }
  }

  void jump() {
    if (!isJumping) {
      this.isJumping = true;
      this.heroSpeedY = -400;
      this.animation = jumpAnimation;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is ObstacleTile) {
      if (this.y + this.hitBox.y / 2 >= other.y) {
        if (other.x < this.x) {
          this.heroSpeedX = 0;
          this.x += 5;
          gameRef.nightParallax.x += 5;
        }
        if (other.x > this.x) {
          this.heroSpeedX = 0;
          this.x -= 5;
          gameRef.nightParallax.x -= 5;
        }
      } else {
        if (!this.isJumping) {
          this.heroSpeedY = 0;
          gravity = 0;
          this.yMax = other.y;
        }
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (other is ObstacleTile) {
      gravity = 1000;
    }
  }
}