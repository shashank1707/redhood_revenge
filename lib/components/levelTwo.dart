
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/enemy.dart';
import 'package:red_hood_revenge/components/heart.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/components/redPotion.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class LevelTwo extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 =
        await Sprite.load('Levels/level2.png', srcSize: Vector2(7588, 149));
    this.sprite = sprite1;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());
    this.addObstacles();
    this.addEnemies();

    gameRef.enemiesRemaining.value = 9;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 7588;
  }

  void addObstacles() {
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;
    final ob1 = ObstacleTile();
    ob1.height = this.height;
    ob1.width = 0.1;
    ob1.x = 665;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = this.height/2;
    ob2.width = 50;
    ob2.x = 1240;
    ob2.y = tileY - ob2.height;
    gameRef.add(ob2);

    final ob3 = ObstacleTile();
    ob3.height = 3*this.height/7;
    ob3.width = 40;
    ob3.x = 1635;
    ob3.y = tileY - ob3.height;
    gameRef.add(ob3);

    final ob4 = ObstacleTile();
    ob4.height = 3*this.height/7;
    ob4.width = 110;
    ob4.x = 1795;
    ob4.y = tileY - ob4.height;
    // gameRef.add(ob4);

    final ob5 = ObstacleTile();
    ob5.height = this.height/2 + 5;
    ob5.width = 50;
    ob5.x = 1825;
    ob5.y = tileY - ob5.height;
    gameRef.add(ob5);

    final ob6 = ObstacleTile();
    ob6.height = 3*this.height/4;
    ob6.width = 180;
    ob6.x = 1950;
    ob6.y = tileY - ob6.height;
    gameRef.add(ob6);

    final ob6_1 = ObstacleTile();
    ob6_1.height = this.height;
    ob6_1.width = 30;
    ob6_1.x = 2025;
    ob6_1.y = tileY - ob6_1.height;
    gameRef.add(ob6_1);

    final ob7 = ObstacleTile();
    ob7.height = this.height/2 + 5;
    ob7.width = 50;
    ob7.x = 2210;
    ob7.y = tileY - ob7.height;
    gameRef.add(ob7);

    final ob8 = ObstacleTile();
    ob8.height = 3*this.height/7;
    ob8.width = 40;
    ob8.x = 2410;
    ob8.y = tileY - ob3.height;
    gameRef.add(ob8);

    final ob9 = ObstacleTile();
    ob9.height = this.height/2;
    ob9.width = 50;
    ob9.x = 2865;
    ob9.y = tileY - ob9.height;
    gameRef.add(ob9);

    final ob10 = ObstacleTile();
    ob10.height = this.height/2 + 5;
    ob10.width = 15;
    ob10.x = 2965;
    ob10.y = tileY - ob10.height;
    gameRef.add(ob10);

    final ob11 = ObstacleTile();
    ob11.height = 3*this.height/4;
    ob11.width = 90;
    ob11.x = 3060;
    ob11.y = tileY - ob11.height;
    gameRef.add(ob11);

    final ob11_1 = ObstacleTile();
    ob11_1.height = this.height;
    ob11_1.width = 30;
    ob11_1.x = 3135;
    ob11_1.y = tileY - ob6_1.height;
    gameRef.add(ob11_1);

    final ob12 = ObstacleTile();
    ob12.height = this.height/2 + 5;
    ob12.width = 15;
    ob12.x = 3255;
    ob12.y = tileY - ob12.height;
    gameRef.add(ob12);

    final ob13 = ObstacleTile();
    ob13.height = 3*this.height/7;
    ob13.width = 40;
    ob13.x = 3415;
    ob13.y = tileY - ob13.height;
    gameRef.add(ob13);

    final ob14 = ObstacleTile();
    ob14.height = this.height/2;
    ob14.width = 50;
    ob14.x = 3950;
    ob14.y = tileY - ob14.height;
    gameRef.add(ob14);

    final ob15 = ObstacleTile();
    ob15.height = this.height/2 + 5;
    ob15.width = 15;
    ob15.x = 4345;
    ob15.y = tileY - ob15.height;
    gameRef.add(ob15);

    final ob16 = ObstacleTile();
    ob16.height = 3*this.height/4;
    ob16.width = 180;
    ob16.x = 4435;
    ob16.y = tileY - ob16.height;
    gameRef.add(ob16);

    final ob16_1 = ObstacleTile();
    ob16_1.height = this.height;
    ob16_1.width = 30;
    ob16_1.x = 4510;
    ob16_1.y = tileY - ob16_1.height;
    gameRef.add(ob16_1);

    final ob17 = ObstacleTile();
    ob17.height = this.height/2 + 5;
    ob17.width = 15;
    ob17.x = 4690;
    ob17.y = tileY - ob17.height;
    gameRef.add(ob17);

    final ob18 = ObstacleTile();
    ob18.height = this.height/2;
    ob18.width = 50;
    ob18.x = 4980;
    ob18.y = tileY - ob18.height;
    gameRef.add(ob18);

    final ob19 = ObstacleTile();
    ob19.height = this.height/2 + 5;
    ob19.width = 15;
    ob19.x = 5080;
    ob19.y = tileY - ob19.height;
    gameRef.add(ob19);

    final ob20 = ObstacleTile();
    ob20.height = 3*this.height/4;
    ob20.width = 90;
    ob20.x = 5170;
    ob20.y = tileY - ob20.height;
    gameRef.add(ob20);

    final ob20_1 = ObstacleTile();
    ob20_1.height = this.height;
    ob20_1.width = 30;
    ob20_1.x = 5245;
    ob20_1.y = tileY - ob20_1.height;
    gameRef.add(ob20_1);

    final ob21 = ObstacleTile();
    ob21.height = this.height/2 + 5;
    ob21.width = 15;
    ob21.x = 5365;
    ob21.y = tileY - ob21.height;
    gameRef.add(ob21);

    final ob22 = ObstacleTile();
    ob22.height = 3*this.height/7;
    ob22.width = 40;
    ob22.x = 5530;
    ob22.y = tileY - ob22.height;
    gameRef.add(ob22);

    final ob23 = ObstacleTile();
    ob23.height = this.height/2 + 5;
    ob23.width = 15;
    ob23.x = 6110;
    ob23.y = tileY - ob23.height;
    gameRef.add(ob23);

    final ob24 = ObstacleTile();
    ob24.height = 3*this.height/4;
    ob24.width = 90;
    ob24.x = 6205;
    ob24.y = tileY - ob24.height;
    gameRef.add(ob24);

    final ob24_1 = ObstacleTile();
    ob24_1.height = this.height;
    ob24_1.width = 30;
    ob24_1.x = 6275;
    ob24_1.y = tileY - ob24_1.height;
    gameRef.add(ob24_1);

    final ob25 = ObstacleTile();
    ob25.height = 2*this.height;
    ob25.width = 1;
    ob25.x = 6325;
    ob25.y = tileY - ob25.height;
    gameRef.add(ob25);

    final redPotion = RedPotion();
    redPotion.x = 6220; redPotion.y = gameRef.canvasSize.y/2  - 60;
    gameRef.add(redPotion);

    final heart1 = Heart();
    heart1.x = 4455; heart1.y = gameRef.canvasSize.y/2 - 60;
    gameRef.add(heart1);
  }

  void addEnemies() {
    final en1 = Enemy(EnemyType.Mushroom);
    en1.x = 1140; en1.y = gameRef.canvasSize.y/2; gameRef.add(en1);

    final en2 = Enemy(EnemyType.Mushroom);
    en2.x = 1710; en2.y = gameRef.canvasSize.y/2; gameRef.add(en2);

    final en3 = Enemy(EnemyType.Mushroom);
    en3.x = 2365; en3.y = gameRef.canvasSize.y/2; gameRef.add(en3);

    final en4 = Enemy(EnemyType.Mushroom);
    en4.x = 2780; en4.y = gameRef.canvasSize.y/2; gameRef.add(en4);

    final en5 = Enemy(EnemyType.Mushroom);
    en5.x = 3365; en5.y = gameRef.canvasSize.y/2; gameRef.add(en5);

    final en6 = Enemy(EnemyType.Mushroom);
    en6.x = 3900; en6.y = gameRef.canvasSize.y/2; gameRef.add(en6);

    final en7 = Enemy(EnemyType.Mushroom);
    en7.x = 4320; en7.y = gameRef.canvasSize.y/2; gameRef.add(en7);

    final en8 = Enemy(EnemyType.Mushroom);
    en8.x = 4930; en8.y = gameRef.canvasSize.y/2; gameRef.add(en8);

    final en9 = Enemy(EnemyType.Goblin);
    en9.x = 6050; en9.y = gameRef.canvasSize.y/2; gameRef.add(en9);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    
  }
}

class LevelTwoFiller extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    final sprite1 =
        await Sprite.load('Levels/level2_filler.png', srcSize: Vector2(7588, 172));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 7588;
  }

  
}
