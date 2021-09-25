
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/nightBorne2.dart';
import 'package:red_hood_revenge/characters/warrior.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class Wizard extends SpriteAnimationComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation attackAnimation;

  late double heroSpeedX = 0;
  late double yCenter = 0;
  late bool isRunning = false;

  Vector2 hitBox = Vector2(40, 40);

  late Timer attackTimer;

  @override
  Future<void> onLoad() async {
    // debugMode = true;

    final idleImage = await Flame.images.load('Heros/wizard/wizard_idle.png');
    final runImage = await Flame.images.load('Heros/wizard/wizard_run.png');
    final attackImage = await Flame.images.load('Heros/wizard/wizard_attack2.png');

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(250, 250))
        .createAnimation(row: 0, stepTime: 0.1, from: 0, to: 8);
    runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(250, 250))
        .createAnimation(row: 0, stepTime: 0.2, from: 0, to: 8);
    attackAnimation = SpriteSheet(image: attackImage, srcSize: Vector2(250, 250)).createAnimation(row: 0, stepTime: 0.1, from: 0, to: 8, loop: false);

    this.animation = idleAnimation;
    this.anchor = Anchor.center;

    var shape = HitboxPolygon([
      Vector2(-0.5, -0.5),
      Vector2(0.5, -0.5),
      Vector2(0.5, 0.5),
      Vector2(-0.5, 0.5),
    ]);

    this.addShape(shape);
    setSize(gameRef.canvasSize);

    attackTimer = Timer(0.8, callback: (){
      this.animation = idleAnimation;
      gameRef.nightBorne2Component.animation = gameRef.nightBorne2Component.deathAnimation;
      gameRef.nightBorne2Component.deathTimer.start();
    });
  }

  void setSize(Vector2 gameSize) {
    this.height = gameSize.x / 2.5;
    this.width = gameSize.x / 2.5;
    this.y = gameRef.canvasSize.y / 2 - 15;
    this.yCenter = this.y;
    this.hitBox = Vector2(this.height / 4, this.height / 4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    attackTimer.update(dt);
    this.x += heroSpeedX * dt;
  }

  void moveForward() {
    this.renderFlipX = false;
    this.animation = runAnimation;

    this.heroSpeedX = 100;
    isRunning = true;
  }

  void moveBackward() {
    this.renderFlipX = true;
    // this.animation = runAnimation;

    this.heroSpeedX = -100;
    isRunning = true;
  }

  void stopMoving() {
    // this.animation = idleAnimation;
    this.heroSpeedX = 0;
    this.isRunning = false;
  }

  void attack(){
    this.animation = attackAnimation;
    attackTimer.start();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Warrior) {
      if (this.x + 2*this.hitBox.x > other.x) {
        this.stopMoving();
      }
    }

    if(other is NightBorne2){
       if (this.x + 2*this.hitBox.x > other.x) {
        this.stopMoving();
        this.x+=5;
        attack();
      }
    }
  }

  // @override
  // void onCollisionEnd(Collidable other) {
  //   super.onCollisionEnd(other);
  //   if (other is ObstacleTile) {
  //     gravity = 1000;
  //     this.yMax = this.yCenter;
  //   }
  // }
}
