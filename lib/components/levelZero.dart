
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/components/bluePotion.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class LevelZero extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 =
        await Sprite.load('Levels/level0.png', srcSize: Vector2(2176, 149));
    this.sprite = sprite1;
    this.height = gameRef.canvasSize.x / 5;
    this.width = 2176;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());
    this.addObstacles();
    if(gameRef.currentLevel >= 1) this.addOtherObstacles();

    gameRef.enemiesRemaining.value = 1;
  }

  void addObstacles() {
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;
    final ob1 = ObstacleTile();
    ob1.height = 2*this.height;
    ob1.width = 0.1;
    ob1.x = 700;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = 2*this.height;
    ob2.width = 0.1;
    ob2.x = 1610;
    ob2.y = tileY - ob2.height;
    gameRef.add(ob2);
  }

  void addOtherObstacles(){
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;

    final ob1 = ObstacleTile();
    ob1.height = 3*this.height/7;
    ob1.width = 100;
    ob1.x = 1460;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = 2*this.height/3;
    ob2.width = 60;
    ob2.x = 1520;
    ob2.y = tileY - ob2.height;
    gameRef.add(ob2);

    final bluePotion = BluePotion();
    bluePotion.x = 1535; bluePotion.y = gameRef.canvasSize.y/2 - gameRef.canvasSize.y/10 - 15;
    gameRef.add(bluePotion);


  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
  }
}

class LevelZeroFiller extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    final sprite1 = await Sprite.load('Levels/level0_filler.png',
        srcSize: Vector2(2176, 172));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 2176;
  }
}
