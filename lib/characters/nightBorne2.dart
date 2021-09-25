import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet10.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet8.dart';
import 'package:red_hood_revenge/widgets/hud.dart';

class NightBorne2 extends SpriteAnimationComponent
    with Hitbox, Collidable, HasGameRef<RedHoodGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation attackAnimation;
  late SpriteAnimation deathAnimation;
  late SpriteAnimation hurtAnimation;
  late SpriteAnimation goneAnimation;
  late SpriteAnimation sitAnimation;

  late bool isAttacking = false;
  late bool isRunning = false;
  late bool isHurting = false;
  late bool isDying = false;
  late bool stillColliding = false;
  late bool stopUpdates = false;

  late Timer attackTimer;
  late Timer hurtTimer;
  late Timer deathTimer;
  late Timer goneTimer;

  Vector2 hitBox = Vector2(40, 40);

  ValueNotifier<double> enemyHealth = ValueNotifier(1.0);

  late double enemySpeed;
  late double enemyCurrentSpeed = 0;
  late double enemyHPRate;
  late double enemyDamage;

  @override
  Future<void> onLoad() async {
    await loadSprites();
    await setSize(gameRef.canvasSize);
    setTimers();

    this.animation = runAnimation;
    this.anchor = Anchor.center;

    var shape = HitboxPolygon([
      Vector2(-0.5, -0.2),
      Vector2(0.5, -0.2),
      Vector2(0.5, 0.8),
      Vector2(-0.5, 0.8),
    ]);

    this.addShape(shape);

    this.enemyHPRate = 0.1;
    this.enemyDamage = 0.34;
    this.enemyCurrentSpeed = 0;
    this.enemySpeed = 280;
    this.enemyHealth.value = 1;
    // debugMode = true;
  }

  Future<void> setSize(Vector2 gameSize) async {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = gameSize.x / 5;
    this.x = 1300;
    this.renderFlipX = true;
    this.y = gameRef.canvasSize.y / 2 - 20;
    this.hitBox = Vector2(this.height / 4, this.height / 4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    deathTimer.update(dt);
    goneTimer.update(dt);
    if (!this.stopUpdates) {
      attackTimer.update(dt);
      hurtTimer.update(dt);

      this.x += enemyCurrentSpeed * dt;

      findHero();
      checkIfHit();
    }
  }

  Future<void> loadSprites() async {
    final idleImage = await Flame.images.load('Enemies/main/main_idle.png');
    final runImage = await Flame.images.load('Enemies/main/main_run.png');
    final attackImage1 =
        await Flame.images.load('Enemies/main/main_attack.png');
    final hurtImage = await Flame.images.load('Enemies/main/main_hurt.png');
    final deathImage = await Flame.images.load('Enemies/main/main_death.png');

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 9);
    runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.075, from: 0, to: 6);
    attackAnimation = SpriteSheet(image: attackImage1, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.075, from: 0, to: 12);
    hurtAnimation = SpriteSheet(image: hurtImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 5);
    deathAnimation = SpriteSheet(image: deathImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.25, from: 0, to: 23);
    goneAnimation = SpriteSheet(image: deathImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.25, from: 16, to: 23);
    sitAnimation = SpriteSheet(image: deathImage, srcSize: Vector2(60, 60))
        .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 4, loop: false);
  }

  void setTimers() {
    attackTimer = Timer(0.9, callback: () {
      if (this.stillColliding) {
        gameRef.redHoodComponent.health.value -= this.enemyDamage;
        gameRef.redHoodComponent.animation =
            gameRef.redHoodComponent.hurtAnimation;
        gameRef.redHoodComponent.isHurting = true;
        gameRef.redHoodComponent.hurtTimer.start();
      }
      this.animation = idleAnimation;
      this.isAttacking = false;
    });
    hurtTimer = Timer(0.4, callback: () {
      if (!this.isAttacking) {
        this.animation = idleAnimation;
      } else {
        this.animation = attackAnimation;
      }
      print(this.enemyHealth.value);
      if (this.enemyHealth.value <= 0.3) {
        if (gameRef.tookBluePotion) {
          this.stopUpdates = true;
          this.isDying = true;
          this.animation = idleAnimation;
          gameRef.redHoodComponent.stopMoving();
          gameRef.redHoodComponent.stopUpdates = true;
          gameRef.redHoodComponent.animation =
              gameRef.redHoodComponent.sitAnimation;
          gameRef.redHoodComponent.renderFlipX = false;
          this.x = gameRef.redHoodComponent.x + 100;
          gameRef.overlays.remove(Hud.id);
          gameRef.overlays.add(DialoguesSet8.id);
        }else{
          this.enemyHealth.value = 0.9;
        }
      }
      this.isHurting = false;
    });

    deathTimer = Timer(5.7, callback: () {
      gameRef.overlays.add(DialoguesSet10.id);
      this.remove();
    });

    goneTimer = Timer(0.8, callback: () {
      this.remove();
    });
  }

  void findHero() {
    if (!this.isHurting) {
      if ((this.distance(gameRef.redHoodComponent) < 200 &&
          this.distance(gameRef.redHoodComponent) > this.hitBox.x)) {
        moveTodardsHero();
      } else {
        stopMoving();
      }
    }
  }

  void moveTodardsHero() {
    if (this.x > gameRef.redHoodComponent.x + this.hitBox.x / 2) {
      this.renderFlipX = true;
      this.enemyCurrentSpeed = -1 * this.enemySpeed;
      if (!this.isAttacking && !this.isHurting && !this.isDying)
        this.animation = runAnimation;
    } else if (this.x < gameRef.redHoodComponent.x - this.hitBox.x / 2) {
      this.renderFlipX = false;
      this.enemyCurrentSpeed = this.enemySpeed;
      if (!this.isAttacking && !this.isHurting && !this.isDying)
        this.animation = runAnimation;
    } else {
      stopMoving();
    }
  }

  void stopMoving() {
    this.enemyCurrentSpeed = 0;
    if (!this.isAttacking && !this.isHurting && !this.isDying) {
      this.animation = idleAnimation;
    }
  }

  void attack() async {
    if (!this.isAttacking &&
        gameRef.redHoodComponent.y >= this.y - this.hitBox.y / 2) {
      this.isAttacking = true;
      this.animation = attackAnimation;
      attackTimer.start();
    }
  }

  void checkIfHit() async {
    if (gameRef.redHoodComponent.hasAttacked &&
        gameRef.redHoodComponent.y >= this.y - this.hitBox.y / 2 &&
        this.stillColliding &&
        !this.isHurting) {
      gameRef.redHoodComponent.hasAttacked = false;
      this.enemyHealth.value -= this.enemyHPRate;
      this.animation = hurtAnimation;
      this.isHurting = true;
      this.hurtTimer.start();

      if (gameRef.redHoodComponent.x < this.x) {
        this.x += this.hitBox.x / 8;
      } else {
        this.x -= this.hitBox.x / 8;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is RedHood) {
      this.stillColliding = true;
      if (!this.stopUpdates) attack();
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (other is RedHood) {
      this.stillColliding = false;
    }
  }
}
