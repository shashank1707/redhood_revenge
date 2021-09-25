
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/warrior.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class TempRedHood extends SpriteAnimationComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation sitAnimation;

  late double heroSpeedX = 0;
  late double yCenter = 0;
  late bool isRunning = false;

  Vector2 hitBox = Vector2(40, 40);

  @override
  Future<void> onLoad() async {
    // debugMode = true;

    final idleImage = await Flame.images.load('Heros/redhood/redhood_idle.png');
    final runImage = await Flame.images.load('Heros/redhood/redhood_run.png');
    final sitImage = await Flame.images.load('Heros/redhood/redhood_hurt.png');

    idleAnimation = SpriteSheet(image: idleImage, srcSize: Vector2(60, 80))
        .createAnimation(row: 0, stepTime: 0.05, from: 0, to: 18);
    runAnimation = SpriteSheet(image: runImage, srcSize: Vector2(60, 80))
        .createAnimation(row: 0, stepTime: 0.025, from: 0, to: 24);
    sitAnimation = SpriteSheet(image: sitImage, srcSize: Vector2(60, 80))
        .createAnimation(row: 0, stepTime: 0.025, from: 5, to: 6);

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
  }

  void setSize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = gameSize.x / 6.66;
    this.y = gameRef.canvasSize.y / 2;
    this.yCenter = this.y;
    this.hitBox = Vector2(this.height / 4, this.height / 4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    this.x += heroSpeedX * dt;
  }

  void moveForward() {
    this.renderFlipX = false;
    this.animation = runAnimation;

    this.heroSpeedX = 100;
    isRunning = true;
  }

  void stopMoving() {
    this.animation = idleAnimation;
    this.heroSpeedX = 0;
    this.isRunning = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Warrior) {
      if (this.x + 2*this.hitBox.x > other.x) {
        this.stopMoving();
        this.animation = sitAnimation;
        
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
