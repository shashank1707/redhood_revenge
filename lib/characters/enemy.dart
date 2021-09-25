import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

enum EnemyType { Eye, Skeleton, Goblin, Mushroom }

class ImageData {
  final imagePath;
  final to;
  final from;
  final srcSize;

  ImageData(
      {@required this.imagePath,
      @required this.to,
      @required this.from,
      @required this.srcSize});
}

class EnemyData {
  final ImageData? idleImageData;
  final ImageData? runImageData;
  final ImageData? attackImageData;
  final ImageData? deathImageData;
  final ImageData? hurtImageData;
  final enemyHPRate;
  final enemySpeed;
  final enemyDamage;

  EnemyData(
      {@required this.idleImageData,
      @required this.runImageData,
      @required this.attackImageData,
      @required this.deathImageData,
      @required this.hurtImageData,
      @required this.enemyHPRate,
      @required this.enemyDamage,
      @required this.enemySpeed});
}

class Enemy extends SpriteAnimationComponent
    with Hitbox, Collidable, HasGameRef<RedHoodGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation hurtAnimation;
  late SpriteAnimation deathAnimation;
  late SpriteAnimation attackAnimation;
  late SpriteAnimation deadAnimation;

  late EnemyData enemyData;
  late double enemySpeed;
  late double enemyCurrentSpeed = 0;
  late double enemyHPRate;
  late double enemyHP;
  late double enemyDamage;

  late bool isAttacking = false;
  late bool isRunning = false;
  late bool isHurting = false;
  late bool isDying = false;
  late bool stillColliding = false;
  late bool stopUpdates = false;

  late Vector2 hitBox;

  late Timer attackTimer;
  late Timer hurtTimer;
  late Timer deathTimer;

  static Map<EnemyType, EnemyData> enemyDetails = {
    EnemyType.Eye: EnemyData(
        idleImageData: ImageData(
            imagePath: 'Enemies/eye/eye_fly.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        runImageData: ImageData(
            imagePath: 'Enemies/eye/eye_fly.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        attackImageData: ImageData(
            imagePath: 'Enemies/eye/eye_attack.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        deathImageData: ImageData(
            imagePath: 'Enemies/eye/eye_death.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        hurtImageData: ImageData(
            imagePath: 'Enemies/eye/eye_hurt.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        enemyHPRate: 0.251,
        enemyDamage: 0.051,
        enemySpeed: 75.0),
    EnemyType.Goblin: EnemyData(
        idleImageData: ImageData(
            imagePath: 'Enemies/goblin/goblin_idle.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        runImageData: ImageData(
            imagePath: 'Enemies/goblin/goblin_run.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        attackImageData: ImageData(
            imagePath: 'Enemies/goblin/goblin_attack.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        deathImageData: ImageData(
            imagePath: 'Enemies/goblin/goblin_death.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        hurtImageData: ImageData(
            imagePath: 'Enemies/goblin/goblin_hurt.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        enemyHPRate: 0.101,
        enemyDamage: 0.151,
        enemySpeed: 100.0),
    EnemyType.Skeleton: EnemyData(
        idleImageData: ImageData(
            imagePath: 'Enemies/skeleton/skeleton_idle.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        runImageData: ImageData(
            imagePath: 'Enemies/skeleton/skeleton_run.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        attackImageData: ImageData(
            imagePath: 'Enemies/skeleton/skeleton_attack.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        deathImageData: ImageData(
            imagePath: 'Enemies/skeleton/skeleton_death.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        hurtImageData: ImageData(
            imagePath: 'Enemies/skeleton/skeleton_hurt.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        enemyHPRate: 0.101,
        enemyDamage: 0.151,
        enemySpeed: 100.0),
    EnemyType.Mushroom: EnemyData(
        idleImageData: ImageData(
            imagePath: 'Enemies/mushroom/mush_idle.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        runImageData: ImageData(
            imagePath: 'Enemies/mushroom/mush_run.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        attackImageData: ImageData(
            imagePath: 'Enemies/mushroom/mush_attack.png',
            to: 8,
            from: 0,
            srcSize: Vector2(150, 150)),
        deathImageData: ImageData(
            imagePath: 'Enemies/mushroom/mush_death.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        hurtImageData: ImageData(
            imagePath: 'Enemies/mushroom/mush_hurt.png',
            to: 4,
            from: 0,
            srcSize: Vector2(150, 150)),
        enemyHPRate: 0.251,
        enemyDamage: 0.051,
        enemySpeed: 75.0)
  };

  Enemy(EnemyType enemyType) {
    enemyData = enemyDetails[enemyType]!;
    enemyHPRate = enemyData.enemyHPRate;
    enemySpeed = enemyData.enemySpeed;
    enemyDamage = enemyData.enemyDamage;
  }

  @override
  Future<void> onLoad() async {
    this.enemyHP = 1.0;

    final idleImage =
        await Flame.images.load(enemyData.idleImageData!.imagePath);
    final runImage = await Flame.images.load(enemyData.runImageData!.imagePath);
    final attackImage =
        await Flame.images.load(enemyData.attackImageData!.imagePath);
    final hurtImage =
        await Flame.images.load(enemyData.hurtImageData!.imagePath);
    final deathImage =
        await Flame.images.load(enemyData.deathImageData!.imagePath);

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(150, 150))
        .createAnimation(
            row: 0,
            stepTime: 0.1,
            from: enemyData.idleImageData!.from,
            to: enemyData.idleImageData!.to);
    runAnimation =
        SpriteSheet(image: runImage, srcSize: enemyData.runImageData!.srcSize)
            .createAnimation(
                row: 0,
                stepTime: 0.1,
                from: enemyData.runImageData!.from,
                to: enemyData.runImageData!.to);
    attackAnimation = SpriteSheet(
            image: attackImage, srcSize: enemyData.attackImageData!.srcSize)
        .createAnimation(
            row: 0,
            stepTime: 0.1,
            from: enemyData.attackImageData!.from,
            to: enemyData.attackImageData!.to);
    deathAnimation = SpriteSheet(
            image: deathImage, srcSize: enemyData.deathImageData!.srcSize)
        .createAnimation(
            row: 0,
            stepTime: 0.2,
            from: enemyData.deathImageData!.from,
            to: enemyData.deathImageData!.to);

    hurtAnimation =
        SpriteSheet(image: hurtImage, srcSize: enemyData.hurtImageData!.srcSize)
            .createAnimation(
                row: 0,
                stepTime: 0.05,
                from: enemyData.hurtImageData!.from,
                to: enemyData.hurtImageData!.to);

    deadAnimation = SpriteSheet(
            image: deathImage, srcSize: enemyData.deathImageData!.srcSize)
        .createAnimation(row: 0, stepTime: 0.2, from: 3, to: 4);

    // addChild(TextComponent(enemyHP.toString(), position: Vector2(this.width/2, this.height/2 - 30), size: Vector2(-0.01, -0.01)));

    this.animation = idleAnimation;
    addShape(HitboxPolygon([
      Vector2(-0.2, -0.3),
      Vector2(0.2, -0.3),
      Vector2(0.2, 0.3),
      Vector2(-0.2, 0.3)
    ]));

    // debugMode = true;
    this.anchor = Anchor.center;

    attackTimer = Timer(0.8, callback: () {
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
    hurtTimer = Timer(0.10, callback: () {
      if (!this.isAttacking) {
        this.animation = idleAnimation;
      } else {
        this.animation = attackAnimation;
      }
      if (this.enemyHP <= 0) {
        this.isDying = true;
        this.hurtTimer.stop();
        this.animation = deathAnimation;
        this.deathTimer.start();
      }
      print(this.enemyHP);
      this.isHurting = false;
    });
    deathTimer = Timer(0.40, callback: () {
      this.stopUpdates = true;
      this.animation = deadAnimation;
      gameRef.enemiesRemaining.value -= 1;
    });
    this.renderFlipX = true;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 3;
    this.width = gameSize.x / 3;
    this.hitBox = Vector2(this.width / 5, this.height / 3);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!this.stopUpdates) {
      attackTimer.update(dt);
      hurtTimer.update(dt);
      deathTimer.update(dt);

      this.x += enemyCurrentSpeed * dt;

      findRedhood();
      checkIfHit();
    } else {
      if (this.distance(gameRef.redHoodComponent) > 500) {
        this.remove();
      }
    }
  }

  void checkIfHit() async {
    if (gameRef.redHoodComponent.hasAttacked &&
        gameRef.redHoodComponent.y >= this.y - this.hitBox.y / 2 &&
        this.stillColliding &&
        !this.isHurting) {
      gameRef.redHoodComponent.hasAttacked = false;
      this.enemyHP -= this.enemyHPRate;
      this.animation = hurtAnimation;
      this.isHurting = true;
      this.hurtTimer.start();

      if (gameRef.redHoodComponent.x < this.x) {
        this.x += this.hitBox.x / 4;
      } else {
        this.x -= this.hitBox.x / 4;
      }

      if (this.enemyHP <= 0) {
        this.isDying = true;
        this.hurtTimer.stop();
        this.animation = deathAnimation;
        this.deathTimer.start();
      }
      print(this.enemyHP);
    }
  }

  void findRedhood() {
    if (!this.isHurting) {
      if (this.distance(gameRef.redHoodComponent) < 200 &&
          this.distance(gameRef.redHoodComponent) > this.hitBox.x / 2) {
        moveTodardsHero();
      } else {
        stopMoving();
      }
    }
  }

  void attack() async {
    if (!this.isAttacking &&
        gameRef.redHoodComponent.y >= this.y - this.hitBox.y / 2 &&
        this.stillColliding) {
      this.isAttacking = true;
      this.animation = attackAnimation;
      attackTimer.start();
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

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is RedHood) {
      if (!this.stopUpdates) {
        this.stillColliding = true;
        attack();
      }else{
        this.stillColliding = false;
        this.animation = deadAnimation;
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    super.onCollisionEnd(other);
    if (other is RedHood) {
      this.stillColliding = false;
      // this.enemyCurrentSpeed = this.enemySpeed;
    }
  }
}
