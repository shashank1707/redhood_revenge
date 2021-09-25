
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class LevelOne extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 =
        await Sprite.load('Levels/level1.png', srcSize: Vector2(2040, 149));
    this.sprite = sprite1;
    this.height = gameRef.canvasSize.x / 5;
    this.width = 2040;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());
    this.addObstacles();

    gameRef.enemiesRemaining.value = 0;
  }


  void addObstacles() {
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;
    final ob1 = ObstacleTile();
    ob1.height = this.height;
    ob1.width = 0.1;
    ob1.x = 400;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = this.height;
    ob2.width = 0.1;
    ob2.x = 1500;
    ob2.y = tileY - ob1.height;
    gameRef.add(ob2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    
  }
}

class LevelOneFiller extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    final sprite1 =
        await Sprite.load('Levels/level1_filler.png', srcSize: Vector2(2057, 172));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 2057;
  }

  
}
