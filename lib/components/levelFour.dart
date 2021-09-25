
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/geometry.dart';
import 'package:red_hood_revenge/characters/enemy.dart';
import 'package:red_hood_revenge/components/greenPotion.dart';
import 'package:red_hood_revenge/components/heart.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class LevelFour extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    // this.debugMode = true;
    final sprite1 =
        await Sprite.load('Levels/level4.png', srcSize: Vector2(7250, 149));
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
    this.width = 7250;
  }

  void addObstacles() {
    final tileY = gameRef.canvasSize.y / 2 + this.height / 2;
    final ob1 = ObstacleTile();
    ob1.height = this.height;
    ob1.width = 0.1;
    ob1.x = 650;
    ob1.y = tileY - ob1.height;
    gameRef.add(ob1);

    final ob2 = ObstacleTile();
    ob2.height = this.height/2;
    ob2.width = 60;
    ob2.x = 1195;
    ob2.y = tileY - ob2.height;
    gameRef.add(ob2);

    final ob3 = ObstacleTile();
    ob3.height = this.height;
    ob3.width = 180;
    ob3.x = 1280;
    ob3.y = tileY - ob3.height;
    gameRef.add(ob3);

    final ob3_1 = ObstacleTile();
    ob3_1.height = 5*this.height/8;
    ob3_1.width = 40;
    ob3_1.x = 1475;
    ob3_1.y = tileY - ob3_1.height;
    gameRef.add(ob3_1);

    final ob4 = ObstacleTile();
    ob4.height = this.height/2;
    ob4.width = 60;
    ob4.x = 1920;
    ob4.y = tileY - ob4.height;
    gameRef.add(ob4);

    final ob5 = ObstacleTile();
    ob5.height = this.height;
    ob5.width = 40;
    ob5.x = 2040;
    ob5.y = tileY - ob5.height;
    gameRef.add(ob5);

    final ob6 = ObstacleTile();
    ob6.height = this.height/2;
    ob6.width = 20;
    ob6.x = 2160;
    ob6.y = tileY - ob6.height;
    gameRef.add(ob6);


    final ob7 = ObstacleTile();
    ob7.height = this.height/2;
    ob7.width = 60;
    ob7.x = 2510;
    ob7.y = tileY - ob7.height;
    gameRef.add(ob7);

    final ob8 = ObstacleTile();
    ob8.height = this.height;
    ob8.width = 180;
    ob8.x = 2590;
    ob8.y = tileY - ob3.height;
    gameRef.add(ob8);

    final ob9 = ObstacleTile();
    ob9.height = 5*this.height/8;
    ob9.width = 100;
    ob9.x = 2790;
    ob9.y = tileY - ob9.height;
    gameRef.add(ob9);

    final ob10 = ObstacleTile();
    ob10.height = 5*this.height/8;
    ob10.width = 80;
    ob10.x = 3410;
    ob10.y = tileY - ob10.height;
    gameRef.add(ob10);

    final ob11 = ObstacleTile();
    ob11.height = this.height;
    ob11.width = 180;
    ob11.x = 3460;
    ob11.y = tileY - ob11.height;
    gameRef.add(ob11);


    final ob12 = ObstacleTile();
    ob12.height = this.height/2;
    ob12.width = 70;
    ob12.x = 3650;
    ob12.y = tileY - ob12.height;
    gameRef.add(ob12);

    final ob13 = ObstacleTile();
    ob13.height = 5*this.height/8;
    ob13.width = 40;
    ob13.x = 3955;
    ob13.y = tileY - ob13.height;
    gameRef.add(ob13);

    final ob14 = ObstacleTile();
    ob14.height = this.height/2;
    ob14.width = 60;
    ob14.x = 4285;
    ob14.y = tileY - ob14.height;
    gameRef.add(ob14);

    final ob15 = ObstacleTile();
    ob15.height = this.height;
    ob15.width = 180;
    ob15.x = 4370;
    ob15.y = tileY - ob15.height;
    gameRef.add(ob15);

    final ob16 = ObstacleTile();
    ob16.height = this.height/2;
    ob16.width = 65;
    ob16.x = 4560;
    ob16.y = tileY - ob16.height;
    gameRef.add(ob16);


    final ob17 = ObstacleTile();
    ob17.height = 5*this.height/8;
    ob17.width = 80;
    ob17.x = 5110;
    ob17.y = tileY - ob17.height;
    gameRef.add(ob17);

    final ob18 = ObstacleTile();
    ob18.height = this.height;
    ob18.width = 180;
    ob18.x = 5155;
    ob18.y = tileY - ob18.height;
    gameRef.add(ob18);

    final ob19 = ObstacleTile();
    ob19.height = this.height/2;
    ob19.width = 70;
    ob19.x = 5340;
    ob19.y = tileY - ob19.height;
    gameRef.add(ob19);

    final ob20 = ObstacleTile();
    ob20.height = 5*this.height/8;
    ob20.width = 90;
    ob20.x = 6100;
    ob20.y = tileY - ob20.height;
    gameRef.add(ob20);


    final ob21 = ObstacleTile();
    ob21.height = 2*this.height;
    ob21.width = 1;
    ob21.x = 6180;
    ob21.y = tileY - ob21.height;
    gameRef.add(ob21);

    final greenPotion = GreenPotion();
    greenPotion.x = 6110; greenPotion.y = gameRef.canvasSize.y/2  - 40;
    gameRef.add(greenPotion);

    final heart1 = Heart();
    heart1.x = 3560;  heart1.y = gameRef.canvasSize.y/2 - gameRef.canvasSize.y/5 - 24;
    gameRef.add(heart1);
  }

  void addEnemies() {
    final en1 = Enemy(EnemyType.Eye);
    en1.x = 1140; en1.y = gameRef.canvasSize.y/2; gameRef.add(en1);

    final en2 = Enemy(EnemyType.Eye);
    en2.x = 1760; en2.y = gameRef.canvasSize.y/2; gameRef.add(en2);

    final en3 = Enemy(EnemyType.Eye);
    en3.x = 2400; en3.y = gameRef.canvasSize.y/2; gameRef.add(en3);

    final en4 = Enemy(EnemyType.Eye);
    en4.x = 2780; en4.y = gameRef.canvasSize.y/2; gameRef.add(en4);

    final en5 = Enemy(EnemyType.Eye);
    en5.x = 3365; en5.y = gameRef.canvasSize.y/2; gameRef.add(en5);

    final en6 = Enemy(EnemyType.Eye);
    en6.x = 3900; en6.y = gameRef.canvasSize.y/2; gameRef.add(en6);

    final en7 = Enemy(EnemyType.Eye);
    en7.x = 4320; en7.y = gameRef.canvasSize.y/2; gameRef.add(en7);

    final en8 = Enemy(EnemyType.Eye);
    en8.x = 4950; en8.y = gameRef.canvasSize.y/2; gameRef.add(en8);

    final en9 = Enemy(EnemyType.Skeleton);
    en9.x = 6050; en9.y = gameRef.canvasSize.y/2; gameRef.add(en9);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    
  }
}

class LevelFourFiller extends SpriteComponent
    with HasGameRef<RedHoodGame>, Hitbox, Collidable {
  @override
  Future<void> onLoad() async {
    final sprite1 =
        await Sprite.load('Levels/level4_filler.png', srcSize: Vector2(7250, 172));
    this.sprite = sprite1;
    this.anchor = Anchor.topLeft;
    
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    this.height = gameSize.x / 5;
    this.width = 7250;
  }

  
}
