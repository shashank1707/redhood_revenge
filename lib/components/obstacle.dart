
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/warrior.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class ObstacleTile extends SpriteComponent with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  

  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 = await Sprite.load('Components/obstacle.png', srcSize: Vector2(287, 177));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    this.addShape(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if(other is Warrior){
      this.gameRef.warriorComponent.heroSpeedX = 0;
      if(this.gameRef.warriorComponent.x > this.x){
        this.gameRef.warriorComponent.x += 5;
        this.gameRef.parallaxComponent.x += 5;
      }else{
        this.gameRef.warriorComponent.x -= 5;
        this.gameRef.parallaxComponent.x -= 5;
      }
    }
  }

  
}