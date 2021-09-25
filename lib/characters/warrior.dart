import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/widgets/hud.dart';

class Warrior extends SpriteAnimationComponent
    with Hitbox, Collidable, HasGameRef<RedHoodGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation1;
  late SpriteAnimation attackAnimation2;
  late SpriteAnimation hurtAnimation;
  late SpriteAnimation deathAnimation;
  late SpriteAnimation deadAnimation;

  late double heroSpeedX = 0;
  late double heroSpeedY = 0;
  late double yMax = 0;
  late double yCenter = 0;
  late double gravity = 1000;
  late bool attackAnim = true;
  late bool isAttacking = false;
  late bool hasAttacked = false;
  late bool isRunning = false;
  late bool isJumping = false;
  late bool isHurting = false;
  late bool stopUpdates = false;
  late bool isDead = false;
  late Timer _timer;
  late Timer hurtTimer;
  late Timer deathTimer;

  Vector2 hitBox = Vector2(40, 40);

  ValueNotifier<double> health = ValueNotifier(1.0);

  @override
  Future<void> onLoad() async {
    await loadSprites();
    await setSize(gameRef.canvasSize);
    setTimers();

    this.animation = idleAnimation;
    this.anchor = Anchor.center;

    var shape = HitboxPolygon([
      Vector2(-0.5, -0.5),
      Vector2(0.5, -0.5),
      Vector2(0.5, 0.85),
      Vector2(-0.5, 0.85),
    ]);

    this.addShape(shape);
    // debugMode = true;
  }

  Future<void> setSize(Vector2 gameSize) async {
    super.onGameResize(gameSize);
    this.height = 137 * ((gameSize.x / 4) / 184);
    this.width = 184 * ((gameSize.x / 4) / 184);

    this.x = 800;
    gameRef.parallaxComponent.x = 800 - gameSize.x / 2;
    this.y = gameRef.canvasSize.y / 2 - 20;
    gameRef.parallaxComponent.y = 800 - 20;
    this.yMax = this.y;
    this.yCenter = this.y;
    this.hitBox = Vector2(this.height / 4, this.height / 4);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!this.stopUpdates) {
      this.x += heroSpeedX * dt;

      gameRef.parallaxComponent.x += heroSpeedX * dt;
      gameRef.parallaxComponent.parallax!.baseVelocity.x = heroSpeedX * dt * 10;

      // v = u + at;
      this.heroSpeedY += gravity * dt;

      // d = si + s * t
      this.y += this.heroSpeedY * dt;
      gameRef.parallaxComponent.y += this.heroSpeedY * dt;

      if (isOnGround()) {
        this.y = this.yMax;
        this.heroSpeedY = 0;
        gameRef.parallaxComponent.y = this.y - this.yCenter;
        this.isJumping = false;
      }

      if (isOnGround() &&
          !this.isRunning &&
          !this.isAttacking &&
          !this.isHurting) {
        this.stopMoving();
      }

      if (!this.isAttacking && this.isHurting) {
        this.animation = hurtAnimation;
      }

      if (!this.isJumping && this.isRunning && !this.isAttacking) {
        this.animation = runAnimation;
      }

      _timer.update(dt);
      hurtTimer.update(dt);
    }

    if (!this.isDead) {
      checkIfDead();
    }

    deathTimer.update(dt);
  }

  Future<void> loadSprites() async {
    final idleImage = await Flame.images.load('Heros/warrior/warror_idle.png');
    final runImage = await Flame.images.load('Heros/warrior/warror_run.png');
    final jumpImage = await Flame.images.load('Heros/warrior/warror_jump.png');
    final attackImage1 =
        await Flame.images.load('Heros/warrior/warror_attack1.png');
    final attackImage2 =
        await Flame.images.load('Heros/warrior/warror_attack2.png');
    final hurtImage = await Flame.images.load('Heros/warrior/warror_hurt.png');
    final deathImage =
        await Flame.images.load('Heros/warrior/warror_death.png');

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 6);
    runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.075, from: 0, to: 8);
    jumpAnimation = SpriteSheet(image: jumpImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 1);
    attackAnimation1 =
        SpriteSheet(image: attackImage1, srcSize: Vector2(184, 137))
            .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 4);
    attackAnimation2 =
        SpriteSheet(image: attackImage2, srcSize: Vector2(184, 137))
            .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 4);
    hurtAnimation = SpriteSheet(image: hurtImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 3);
    deathAnimation = SpriteSheet(image: deathImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.25, from: 0, to: 9);
    deadAnimation = SpriteSheet(image: deathImage, srcSize: Vector2(184, 137))
        .createAnimation(row: 0, stepTime: 0.25, from: 8, to: 9);
  }

  void setTimers() {
    _timer = Timer(0.45, callback: () {
      this.animation = idleAnimation;
      this.isAttacking = false;
      this.hasAttacked = false;
    });

    hurtTimer = Timer(0.15, callback: () {
      this.isHurting = false;
    });

    deathTimer = Timer(2.2, callback: () {
      this.animation = deadAnimation;
      gameRef.nightBorneComponent.animation = gameRef.nightBorneComponent.goneAnimation;
      gameRef.nightBorneComponent.goneTimer.start();
      gameRef.tempRedHood.moveForward();
      gameRef.wizardComponent.moveBackward();
    });
  }

  void moveForward() {
    this.renderFlipX = false;
    if (!this.isJumping) {
      this.animation = runAnimation;
    }
    this.heroSpeedX = 200;
    isRunning = true;
  }

  void moveBackward() {
    this.renderFlipX = true;
    if (!this.isJumping) {
      this.animation = runAnimation;
    }
    this.heroSpeedX = -200;
    isRunning = true;
  }

  void stopMoving() {
    this.animation = idleAnimation;
    this.isAttacking = false;
    this.hasAttacked = false;
    this.heroSpeedX = 0;
    gameRef.parallaxComponent.parallax!.baseVelocity.x = 0;
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
      this.hasAttacked = true;
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
    if (!isJumping && isOnGround()) {
      this.isJumping = true;
      this.heroSpeedY = -400;
      this.animation = jumpAnimation;
    }
  }

  void checkIfDead() {
    if (this.health.value <= 0) {
      this.stopUpdates = true;
      this.isDead = true;
      this.animation = deathAnimation;
      gameRef.nightBorneComponent.stopUpdates = true;
      gameRef.nightBorneComponent.animation =
          gameRef.nightBorneComponent.idleAnimation;
      
      
      if (gameRef.overlays.isActive(WarriorHud.id)) {
        gameRef.overlays.remove(WarriorHud.id);
      }
      this.y = yCenter;
      this.renderFlipX = false;
      gameRef.parallaxComponent.parallax!.baseVelocity.x = 0;
      deathTimer.start();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
  }
}
