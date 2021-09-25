
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class BluePotion extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 = await Sprite.load('Components/potion_blue.png',
        srcSize: Vector2(60, 60));
    this.sprite = sprite1;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());

    this.height = 30;
    this.width = 30;
  }

  @override
  Future<void> onCollision(
      Set<Vector2> intersectionPoints, Collidable other) async {
    super.onCollision(intersectionPoints, other);
    if (other is RedHood) {
      gameRef.redHoodComponent.maxSpeed = 350;
      gameRef.nightBorne2Component.enemyHPRate = 0.15;
      gameRef.redHoodComponent.health.value = 1;
      gameRef.tookBluePotion = true;
      this.remove();
    }
  }
}
