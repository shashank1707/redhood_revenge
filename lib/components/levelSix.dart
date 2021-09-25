
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/enemy.dart';
import 'package:red_hood_revenge/components/heart.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/components/purplePotion.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class LevelSix extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 =
        await Sprite.load('Levels/level6.png', srcSize: Vector2(6434, 149));
    this.sprite = sprite1;
    this.anchor = Anchor.centerLeft;
    this.addShape(HitboxRectangle());
    this.addObstacles();
    this.addEnemies();

    gameRef.enemiesRemaining.value = 10;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 6434;
  }

  void addObstacles() {
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;
    final ob1 = ObstacleTile();
    ob1.height = this.height;
    ob1.width = 0.1;
    ob1.x = 680;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = 4*this.height/9;
    ob2.width = 60;
    ob2.x = 1090;
    ob2.y = tileY - ob2.height;
    gameRef.add(ob2);

    final ob3 = ObstacleTile();
    ob3.height = 2*this.height/3;
    ob3.width = 180;
    ob3.x = 1160;
    ob3.y = tileY - ob3.height;
    gameRef.add(ob3);

    final ob4 = ObstacleTile();
    ob4.height = this.height;
    ob4.width = 20;
    ob4.x = 1240;
    ob4.y = tileY - ob4.height;
    gameRef.add(ob4);

    final ob5 = ObstacleTile();
    ob5.height = 4*this.height/9;
    ob5.width = 20;
    ob5.x = 1545;
    ob5.y = tileY - ob5.height;
    gameRef.add(ob5);

    final ob6 = ObstacleTile();
    ob6.height = 2*this.height/3;
    ob6.width = 60;
    ob6.x = 1615;
    ob6.y = tileY - ob6.height;
    gameRef.add(ob6);

    final ob7 = ObstacleTile();
    ob7.height = 4*this.height/9;
    ob7.width = 60;
    ob7.x = 1995;
    ob7.y = tileY - ob7.height;
    gameRef.add(ob7);

    final ob8 = ObstacleTile();
    ob8.height = 2*this.height/3;
    ob8.width = 60;
    ob8.x = 2070;
    ob8.y = tileY - ob3.height;
    gameRef.add(ob8);

    final ob9 = ObstacleTile();
    ob9.height = this.height;
    ob9.width = 20;
    ob9.x = 2150;
    ob9.y = tileY - ob9.height;
    gameRef.add(ob9);

    final ob10 = ObstacleTile();
    ob10.height = 2*this.height/3;
    ob10.width = 60;
    ob10.x = 2235;
    ob10.y = tileY - ob10.height;
    gameRef.add(ob10);

    final ob11 = ObstacleTile();
    ob11.height = 4*this.height/9;
    ob11.width = 20;
    ob11.x = 2365;
    ob11.y = tileY - ob11.height;
    gameRef.add(ob11);

    final ob12 = ObstacleTile();
    ob12.height = 4*this.height/9;
    ob12.width = 25;
    ob12.x = 2825;
    ob12.y = tileY - ob12.height;
    gameRef.add(ob12);

    final ob13 = ObstacleTile();
    ob13.height = 2*this.height/3;
    ob13.width = 60;
    ob13.x = 2900;
    ob13.y = tileY - ob13.height;
    gameRef.add(ob13);

    final ob14 = ObstacleTile();
    ob14.height = 4*this.height/9;
    ob14.width = 60;
    ob14.x = 3315;
    ob14.y = tileY - ob14.height;
    gameRef.add(ob14);

    final ob15 = ObstacleTile();
    ob15.height = 2*this.height/3;
    ob15.width = 80;
    ob15.x = 3400;
    ob15.y = tileY - ob15.height;
    gameRef.add(ob15);

    final ob16 = ObstacleTile();
    ob16.height = this.height;
    ob16.width = 20;
    ob16.x = 3480;
    ob16.y = tileY - ob16.height;
    gameRef.add(ob16);


    final ob17 = ObstacleTile();
    ob17.height = 3*this.height/5;
    ob17.width = 60;
    ob17.x = 3570;
    ob17.y = tileY - ob17.height;
    gameRef.add(ob17);

    final ob18 = ObstacleTile();
    ob18.height = 4*this.height/9;
    ob18.width = 20;
    ob18.x = 3720;
    ob18.y = tileY - ob18.height;
    gameRef.add(ob18);

    final ob19 = ObstacleTile();
    ob19.height = 4*this.height/9;
    ob19.width = 200;
    ob19.x = 4170;
    ob19.y = tileY - ob19.height;
    gameRef.add(ob19);

    final ob20 = ObstacleTile();
    ob20.height = 3*this.height/5;
    ob20.width = 60;
    ob20.x = 4235;
    ob20.y = tileY - ob20.height;
    gameRef.add(ob20);


    final ob21 = ObstacleTile();
    ob21.height = 4*this.height/9;
    ob21.width = 20;
    ob21.x = 4810;
    ob21.y = tileY - ob21.height;
    gameRef.add(ob21);

    final ob22 = ObstacleTile();
    ob22.height = 3*this.height/5;
    ob22.width = 70;
    ob22.x = 4890;
    ob22.y = tileY - ob22.height;
    gameRef.add(ob22);

    final ob23 = ObstacleTile();
    ob23.height = 2*this.height;
    ob23.width = 1;
    ob23.x = 4995;
    ob23.y = tileY - ob23.height;
    gameRef.add(ob23);

    final purplePotion = PurplePotion();
    purplePotion.x = 4910; purplePotion.y = gameRef.canvasSize.y/2  - 40;
    gameRef.add(purplePotion);

    final heart1 = Heart();
    heart1.x = 4255;  heart1.y = gameRef.canvasSize.y/2 - gameRef.canvasSize.y/10;
    gameRef.add(heart1);
  }

  void addEnemies() {
    final en1 = Enemy(EnemyType.Mushroom);
    en1.x = 1050; en1.y = gameRef.canvasSize.y/2; gameRef.add(en1);

    final en2 = Enemy(EnemyType.Eye);
    en2.x = 1470; en2.y = gameRef.canvasSize.y/2; gameRef.add(en2);

    final en3 = Enemy(EnemyType.Eye);
    en3.x = 1975; en3.y = gameRef.canvasSize.y/2; gameRef.add(en3);

    final en4 = Enemy(EnemyType.Mushroom);
    en4.x = 2330; en4.y = gameRef.canvasSize.y/2; gameRef.add(en4);

    final en5 = Enemy(EnemyType.Mushroom);
    en5.x = 2780; en5.y = gameRef.canvasSize.y/2; gameRef.add(en5);

    final en6 = Enemy(EnemyType.Eye);
    en6.x = 3250; en6.y = gameRef.canvasSize.y/2; gameRef.add(en6);

    final en7 = Enemy(EnemyType.Mushroom);
    en7.x = 3685; en7.y = gameRef.canvasSize.y/2; gameRef.add(en7);

    final en8 = Enemy(EnemyType.Eye);
    en8.x = 4110; en8.y = gameRef.canvasSize.y/2; gameRef.add(en8);

    final en9 = Enemy(EnemyType.Goblin);
    en9.x = 4475; en9.y = gameRef.canvasSize.y/2; gameRef.add(en9);

    final en9_1 = Enemy(EnemyType.Skeleton);
    en9_1.x = 4770; en9_1.y = gameRef.canvasSize.y/2; gameRef.add(en9_1);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    
  }
}

class LevelSixFiller extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    final sprite1 =
        await Sprite.load('Levels/level6_filler.png', srcSize: Vector2(6434, 172));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 6434;
  }

  
}
