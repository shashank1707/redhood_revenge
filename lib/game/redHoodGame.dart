import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/characters/enemy.dart';
import 'package:red_hood_revenge/characters/nightBorne.dart';
import 'package:red_hood_revenge/characters/nightBorne2.dart';
import 'package:red_hood_revenge/characters/redHood.dart';
import 'package:red_hood_revenge/characters/tempRedhood.dart';
import 'package:red_hood_revenge/characters/warrior.dart';
import 'package:red_hood_revenge/characters/wizard.dart';
import 'package:red_hood_revenge/components/bluePotion.dart';
import 'package:red_hood_revenge/components/greenPotion.dart';
import 'package:red_hood_revenge/components/heart.dart';
import 'package:red_hood_revenge/components/levelFour.dart';
import 'package:red_hood_revenge/components/levelSix.dart';
import 'package:red_hood_revenge/components/levelTwo.dart';
import 'package:red_hood_revenge/components/levelZero.dart';
import 'package:red_hood_revenge/components/levelOne.dart';
import 'package:red_hood_revenge/components/obstacle.dart';
import 'package:red_hood_revenge/components/purplePotion.dart';
import 'package:red_hood_revenge/components/redPotion.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet1.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet2.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet3.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet4.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet5.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet6.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet7.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet9.dart';
import 'package:red_hood_revenge/widgets/fadeAnimation.dart';
import 'package:red_hood_revenge/widgets/hud.dart';
import 'package:red_hood_revenge/widgets/pauseMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedHoodGame extends BaseGame with TapDetector, HasCollidables {
  late bool visible = false;

  late int currentLevel = 0;

  late ParallaxComponent parallaxComponent;
  late ParallaxComponent onePrallaxComponent;
  late ParallaxComponent twoParallaxComponent;
  late ParallaxComponent threeParallaxComponent;
  late ParallaxComponent fourParallaxCmponent;

  late LevelZero levelZero;
  late LevelZeroFiller levelZeroFiller;
  late bool loadedLevelZero = false;
  late bool completedLevelZero = false;
  late bool shouldLoadZero = false;
  late bool diaSet1 = false;
  late bool diaSet2 = false;
  late bool diaSet3 = false;

  late LevelOne levelOne;
  late LevelOneFiller levelOneFiller;
  late bool loadedLevelOne = false;
  late bool completedLevelOne = false;
  late bool diaSet4 = false;

  late LevelTwo levelTwo;
  late LevelTwoFiller levelTwoFiller;
  late bool loadedLevelTwo = false;
  late bool completedLevelTwo = false;

  late bool diaSet5 = false;
  late bool loadedLevelThree = false;
  late bool completedLevelThree = false;

  late LevelFour levelFour;
  late LevelFourFiller levelFourFiller;
  late bool loadedLevelFour = false;
  late bool completedLevelFour = false;

  late bool diaSet6 = false;
  late bool loadedLevelFive = false;
  late bool completedLevelFive = false;

  late LevelSix levelSix;
  late LevelSixFiller levelSixFiller;
  late bool loadedLevelSix = false;
  late bool completedLevelSix = false;

  late bool diaSet7 = false;
  late bool loadedLevelSeven = false;
  late bool completedLevelSeven = false;

  late bool diaSet8 = false;
  late bool diaSet9 = false;
  late bool diaSet10 = false;
  late bool tookBluePotion = false;
  late bool loadedLevelEight = false;
  late bool completedLevelEight = false;

  late Warrior warriorComponent;
  late NightBorne nightBorneComponent;
  late TempRedHood tempRedHood;
  late Wizard wizardComponent;
  late RedHood redHoodComponent;
  late NightBorne2 nightBorne2Component;

  late ValueNotifier<int> enemiesRemaining = ValueNotifier(1);

  RedHoodGame(currentLevel) {
    this.currentLevel = currentLevel;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        pauseGame();
        break;
      case AppLifecycleState.paused:
        pauseGame();
        break;
      case AppLifecycleState.detached:
        pauseGame();
        break;
    }
  }

  @override
  Future<void> onLoad() async {
    this.parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('Parallax/level0/background_1.png'),
        ParallaxImageData('Parallax/level0/background_3.png'),
        ParallaxImageData('Parallax/level0/background_4.png'),
        ParallaxImageData('Parallax/level0/background_5.png'),
        ParallaxImageData('Parallax/level0/background_6.png'),
        ParallaxImageData('Parallax/level0/background_7.png'),
        ParallaxImageData('Parallax/level0/background_8.png'),
        ParallaxImageData('Parallax/level0/background_9.png'),
        ParallaxImageData('Parallax/level0/background_10.png'),
      ],
      velocityMultiplierDelta: Vector2(1.1, 0),
    );
    add(parallaxComponent);
    loadLevel(this.currentLevel);
  }

  void pauseGame() {
    this.pauseEngine();
    overlays.add(PauseMenu.id);
  }

  void loadLevel(level) {
    this.shouldLoadZero = false;
    switch (level) {
      case 0:
        this.shouldLoadZero = true;
        loadLevelZero();
        break;
      case 1:
        loadLevelOne();
        break;
      case 2:
        loadLevelTwo();
        break;
      case 3:
        loadLevelThree();
        break;
      case 4:
        loadLevelFour();
        break;
      case 5:
        loadLevelFive();
        break;
      case 6:
        loadLevelSix();
        break;
      case 7:
        loadLevelSeven();
        break;
      case 8:
        loadLevelEight();
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldLoadZero &&
        !this.loadedLevelZero &&
        this.warriorComponent.x > 0.0) {
      this.loadedLevelZero = true;
      this.visible = true;
      overlays.add(FadeAnimation.id);
      this.currentLevel = 0;
    }
    if (this.loadedLevelZero && !completedLevelZero) {
      runLevelZeroScript();
    }
    if (this.loadedLevelOne && !completedLevelOne) {
      runLevelOneScript();
    }
    if (this.loadedLevelThree && !completedLevelThree) {
      runLevelThreeScript();
    }
    if (this.loadedLevelFive && !completedLevelFive) {
      runLevelFiveScript();
    }
    if (this.loadedLevelSeven && !completedLevelSeven) {
      runLevelSevenScript();
    }
    if (this.loadedLevelEight && !completedLevelEight) {
      runLevelEightScript();
    }
  }

  void removeEverything() {
    this.visible = false;
    components.whereType<ObstacleTile>().forEach((element) {
      element.remove();
    });
    components.whereType<Enemy>().forEach((element) {
      element.remove();
    });
    switch (this.currentLevel) {
      case 0:
        components.removeAll([
          warriorComponent,
          tempRedHood,
          wizardComponent,
          levelZero,
          levelZeroFiller
        ]);
        this.completedLevelZero = true;
        break;
      case 1:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        this.completedLevelOne = true;
        break;
      case 2:
        components.removeAll([redHoodComponent, levelTwo, levelTwoFiller]);
        components.whereType<RedPotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        this.completedLevelTwo = true;
        break;
      case 3:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        this.completedLevelThree = true;
        break;
      case 4:
        components.removeAll([redHoodComponent, levelFour, levelFourFiller]);
        components.whereType<GreenPotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        this.completedLevelFour = true;
        break;
      case 5:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        this.completedLevelFive = true;
        break;
      case 6:
        components.removeAll([redHoodComponent, levelSix, levelSixFiller]);
        components.whereType<PurplePotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        this.completedLevelSix = true;
        break;
      case 7:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        this.completedLevelSeven = true;
        break;
      case 8:
        components.removeAll([
          redHoodComponent,
          wizardComponent,
          nightBorne2Component,
          levelZero,
          levelZeroFiller
        ]);
        components.whereType<BluePotion>().forEach((element) {
          element.remove();
        });
        this.completedLevelEight = true;
        break;
    }
  }

  void removeEverythingAndRestart() {
    this.visible = false;
    components.whereType<ObstacleTile>().forEach((element) {
      element.remove();
    });
    components.whereType<Enemy>().forEach((element) {
      element.remove();
    });
    switch (this.currentLevel) {
      case 0:
        components.removeAll([
          warriorComponent,
          tempRedHood,
          wizardComponent,
          levelZero,
          levelZeroFiller
        ]);
        break;
      case 1:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        break;
      case 2:
        components.removeAll([redHoodComponent, levelTwo, levelTwoFiller]);
        components.whereType<RedPotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        break;
      case 3:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        break;
      case 4:
        components.removeAll([redHoodComponent, levelFour, levelFourFiller]);
        components.whereType<GreenPotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        break;
      case 5:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        break;
      case 6:
        components.removeAll([redHoodComponent, levelSix, levelSixFiller]);
        components.whereType<PurplePotion>().forEach((element) {
          element.remove();
        });
        components.whereType<Heart>().forEach((element) {
          element.remove();
        });
        break;
      case 7:
        components.removeAll(
            [redHoodComponent, wizardComponent, levelOne, levelOneFiller]);
        break;
      case 8:
        components.removeAll([
          redHoodComponent,
          wizardComponent,
          nightBorne2Component,
          levelZero,
          levelZeroFiller
        ]);
        components.whereType<BluePotion>().forEach((element) {
          element.remove();
        });
        break;
    }
    loadLevel(this.currentLevel);
  }

  Future<void> loadLevelZero() async {
    final newParallax = await loadParallaxComponent(
      [
        ParallaxImageData('Parallax/level0/background_1.png'),
        ParallaxImageData('Parallax/level0/background_3.png'),
        ParallaxImageData('Parallax/level0/background_4.png'),
        ParallaxImageData('Parallax/level0/background_5.png'),
        ParallaxImageData('Parallax/level0/background_6.png'),
        ParallaxImageData('Parallax/level0/background_7.png'),
        ParallaxImageData('Parallax/level0/background_8.png'),
        ParallaxImageData('Parallax/level0/background_9.png'),
        ParallaxImageData('Parallax/level0/background_10.png'),
      ],
      velocityMultiplierDelta: Vector2(1.1, 0),
    );

    this.parallaxComponent.parallax = newParallax.parallax;

    levelZero = LevelZero();
    levelZero.x = 0;
    levelZero.y = canvasSize.y / 2;

    levelZeroFiller = LevelZeroFiller();
    levelZeroFiller.x = 0;
    levelZeroFiller.y = canvasSize.y / 2 + canvasSize.x / 10;

    warriorComponent = Warrior();
    nightBorneComponent = NightBorne();

    tempRedHood = TempRedHood();
    tempRedHood.x = 300;

    wizardComponent = Wizard();
    wizardComponent.x = 2200;

    add(levelZeroFiller);
    add(levelZero);
    add(warriorComponent);
    add(nightBorneComponent);
    add(tempRedHood);
    add(wizardComponent);

    camera.followComponent(warriorComponent);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelZeroScript() {
    if (!this.diaSet1) {
      this.warriorComponent.stopUpdates = true;
      this.warriorComponent.stopMoving();
      this.nightBorneComponent.stopUpdates = true;
      this.overlays.remove(WarriorHud.id);
      this.overlays.add(DialoguesSet1.id);
      this.diaSet1 = true;
    }

    if (!this.diaSet2) {
      if (this.warriorComponent.distance(this.nightBorneComponent) < 300) {
        this.warriorComponent.stopUpdates = true;
        this.warriorComponent.stopMoving();
        this.nightBorneComponent.stopUpdates = true;
        this.overlays.remove(WarriorHud.id);
        this.overlays.add(DialoguesSet2.id);
        this.diaSet2 = true;
      }
    }

    if (!this.diaSet3) {
      if (this.tempRedHood.animation == this.tempRedHood.sitAnimation) {
        this.warriorComponent.stopUpdates = true;
        this.overlays.add(DialoguesSet3.id);
        this.diaSet3 = true;
      }
    }
  }

  Future<void> loadLevelOne() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level0/0.png'),
      ParallaxImageData('Parallax/level0/1.png'),
      ParallaxImageData('Parallax/level0/2.png'),
      ParallaxImageData('Parallax/level0/3.png'),
    ]);

    parallaxComponent.parallax = newParallax.parallax;

    levelOne = LevelOne();
    levelOne.x = 0;
    levelOne.y = canvasSize.y / 2 - 2;

    levelOneFiller = LevelOneFiller();
    levelOneFiller.x = 0;
    levelOneFiller.y = canvasSize.y / 2 + canvasSize.x / 10 - 9;

    redHoodComponent = RedHood();
    wizardComponent = Wizard();
    wizardComponent.x = 1000;
    wizardComponent.renderFlipX = true;

    add(levelOneFiller);
    add(levelOne);
    add(redHoodComponent);
    add(wizardComponent);

    camera.followComponent(redHoodComponent);

    await Future.delayed(Duration(seconds: 1)).then((value) {
      this.changePriorities({
        levelOneFiller: 0,
        levelOne: 1,
        wizardComponent: 2,
        redHoodComponent: 3
      });
      this.visible = true;
      this.loadedLevelOne = true;
      overlays.add(Hud.id);
      overlays.add(FadeAnimation.id);
    });

    this.currentLevel = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelOneScript() {
    if (!diaSet4) {
      if (this.redHoodComponent.distance(this.wizardComponent) < 150) {
        overlays.remove(Hud.id);
        overlays.add(DialoguesSet4.id);
        this.redHoodComponent.stopMoving();
        this.diaSet4 = true;
      }
    }
  }

  Future<void> loadLevelTwo() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level2/SET1_bakcground_night1.png'),
      ParallaxImageData('Parallax/level2/SET1_bakcground_night2.png'),
      ParallaxImageData('Parallax/level2/SET1_bakcground_night3.png'),
    ], velocityMultiplierDelta: Vector2(1.1, 0));
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelTwo = LevelTwo();
    levelTwo.x = 0;
    levelTwo.y = canvasSize.y / 2;

    this.levelTwoFiller = LevelTwoFiller();
    levelTwoFiller.x = 0;
    levelTwoFiller.y = canvasSize.y / 2 + canvasSize.x / 10;

    this.redHoodComponent = RedHood();

    add(levelTwo);
    add(levelTwoFiller);
    add(redHoodComponent);

    camera.followComponent(redHoodComponent);

    this.changePriorities({redHoodComponent: 10});

    this.visible = true;
    overlays.add(Hud.id);
    overlays.add(FadeAnimation.id);

    this.currentLevel = 2;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  Future<void> loadLevelThree() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level0/0.png'),
      ParallaxImageData('Parallax/level0/1.png'),
      ParallaxImageData('Parallax/level0/2.png'),
      ParallaxImageData('Parallax/level0/3.png'),
    ]);
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelOne = LevelOne();
    this.levelOne.x = 0;
    this.levelOne.y = canvasSize.y / 2 - 2;

    levelOneFiller = LevelOneFiller();
    levelOneFiller.x = 0;
    levelOneFiller.y = canvasSize.y / 2 + canvasSize.x / 10 - 9;

    add(this.levelOneFiller);
    add(this.levelOne);

    this.redHoodComponent = RedHood();
    add(this.redHoodComponent);
    camera.followComponent(this.redHoodComponent);

    this.wizardComponent = Wizard();
    wizardComponent.x = 1000;
    wizardComponent.renderFlipX = true;
    add(wizardComponent);

    await Future.delayed(Duration(seconds: 1)).then((value) {
      this.changePriorities({
        levelOneFiller: 0,
        levelOne: 1,
        wizardComponent: 2,
        redHoodComponent: 3
      });
      this.visible = true;
      this.loadedLevelThree = true;
      overlays.add(Hud.id);
      overlays.add(FadeAnimation.id);
    });

    this.currentLevel = 3;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelThreeScript() {
    if (!diaSet5) {
      if (this.redHoodComponent.distance(this.wizardComponent) < 150) {
        overlays.remove(Hud.id);
        overlays.add(DialoguesSet5.id);
        this.redHoodComponent.stopMoving();
        this.diaSet5 = true;
      }
    }
  }

  Future<void> loadLevelFour() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level4/background.png'),
    ]);
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelFour = LevelFour();
    levelFour.x = 0;
    levelFour.y = canvasSize.y / 2;

    this.levelFourFiller = LevelFourFiller();
    levelFourFiller.x = 0;
    levelFourFiller.y = canvasSize.y / 2 + canvasSize.x / 10;

    add(levelFour);
    add(levelFourFiller);

    this.redHoodComponent = RedHood();
    add(redHoodComponent);

    camera.followComponent(redHoodComponent);

    this.changePriorities({redHoodComponent: 10});

    this.visible = true;
    overlays.add(Hud.id);
    overlays.add(FadeAnimation.id);

    this.currentLevel = 4;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  Future<void> loadLevelFive() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level0/0.png'),
      ParallaxImageData('Parallax/level0/1.png'),
      ParallaxImageData('Parallax/level0/2.png'),
      ParallaxImageData('Parallax/level0/3.png'),
    ]);
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelOne = LevelOne();
    this.levelOne.x = 0;
    this.levelOne.y = canvasSize.y / 2 - 2;

    levelOneFiller = LevelOneFiller();
    levelOneFiller.x = 0;
    levelOneFiller.y = canvasSize.y / 2 + canvasSize.x / 10 - 9;

    add(this.levelOneFiller);
    add(this.levelOne);

    this.redHoodComponent = RedHood();
    add(this.redHoodComponent);
    camera.followComponent(this.redHoodComponent);

    this.wizardComponent = Wizard();
    wizardComponent.x = 1000;
    wizardComponent.renderFlipX = true;
    add(wizardComponent);

    await Future.delayed(Duration(seconds: 1)).then((value) {
      this.changePriorities({
        levelOneFiller: 0,
        levelOne: 1,
        wizardComponent: 2,
        redHoodComponent: 3
      });
      this.visible = true;
      this.loadedLevelFive = true;
      overlays.add(Hud.id);
      overlays.add(FadeAnimation.id);
    });

    this.currentLevel = 5;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelFiveScript() {
    if (!diaSet6) {
      if (this.redHoodComponent.distance(this.wizardComponent) < 150) {
        overlays.remove(Hud.id);
        overlays.add(DialoguesSet6.id);
        this.redHoodComponent.stopMoving();
        this.diaSet6 = true;
      }
    }
  }

  Future<void> loadLevelSix() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level6/background_0.png'),
      ParallaxImageData('Parallax/level6/background_1.png'),
      ParallaxImageData('Parallax/level6/background_2.png'),
    ]);
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelSix = LevelSix();
    levelSix.x = 0;
    levelSix.y = canvasSize.y / 2;

    this.levelSixFiller = LevelSixFiller();
    levelSixFiller.x = 0;
    levelSixFiller.y = canvasSize.y / 2 + canvasSize.x / 10 - 2;
    add(levelSixFiller);
    add(levelSix);

    this.redHoodComponent = RedHood();
    add(redHoodComponent);

    camera.followComponent(redHoodComponent);

    this.changePriorities({redHoodComponent: 10});

    this.visible = true;
    overlays.add(Hud.id);
    overlays.add(FadeAnimation.id);

    this.currentLevel = 6;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  Future<void> loadLevelSeven() async {
    final newParallax = await loadParallaxComponent([
      ParallaxImageData('Parallax/level0/0.png'),
      ParallaxImageData('Parallax/level0/1.png'),
      ParallaxImageData('Parallax/level0/2.png'),
      ParallaxImageData('Parallax/level0/3.png'),
    ]);
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelOne = LevelOne();
    this.levelOne.x = 0;
    this.levelOne.y = canvasSize.y / 2 - 2;

    levelOneFiller = LevelOneFiller();
    levelOneFiller.x = 0;
    levelOneFiller.y = canvasSize.y / 2 + canvasSize.x / 10 - 9;

    add(this.levelOneFiller);
    add(this.levelOne);

    this.redHoodComponent = RedHood();
    add(this.redHoodComponent);
    camera.followComponent(this.redHoodComponent);

    this.wizardComponent = Wizard();
    wizardComponent.x = 1000;
    wizardComponent.renderFlipX = true;
    add(wizardComponent);

    await Future.delayed(Duration(seconds: 1)).then((value) {
      this.changePriorities({
        levelOneFiller: 0,
        levelOne: 1,
        wizardComponent: 2,
        redHoodComponent: 3
      });
      this.visible = true;
      this.loadedLevelSeven = true;
      overlays.add(Hud.id);
      overlays.add(FadeAnimation.id);
    });

    this.currentLevel = 7;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelSevenScript() {
    if (!diaSet7) {
      if (this.redHoodComponent.distance(this.wizardComponent) < 150) {
        overlays.remove(Hud.id);
        overlays.add(DialoguesSet7.id);
        this.redHoodComponent.stopMoving();
        this.diaSet7 = true;
      }
    }
  }

  Future<void> loadLevelEight() async {
    final newParallax = await loadParallaxComponent(
      [
        ParallaxImageData('Parallax/level0/background_1.png'),
        ParallaxImageData('Parallax/level0/background_3.png'),
        ParallaxImageData('Parallax/level0/background_4.png'),
        ParallaxImageData('Parallax/level0/background_5.png'),
        ParallaxImageData('Parallax/level0/background_6.png'),
        ParallaxImageData('Parallax/level0/background_7.png'),
        ParallaxImageData('Parallax/level0/background_8.png'),
        ParallaxImageData('Parallax/level0/background_9.png'),
        ParallaxImageData('Parallax/level0/background_10.png'),
      ],
      velocityMultiplierDelta: Vector2(1.1, 0),
    );
    this.parallaxComponent.parallax = newParallax.parallax;

    this.levelZero = LevelZero();
    levelZero.x = 0;
    levelZero.y = canvasSize.y / 2;

    this.levelZeroFiller = LevelZeroFiller();
    levelZeroFiller.x = 0;
    levelZeroFiller.y = canvasSize.y / 2 + canvasSize.x / 10;
    add(levelZeroFiller);
    add(levelZero);

    this.redHoodComponent = RedHood();
    add(redHoodComponent);

    camera.followComponent(redHoodComponent);

    this.nightBorne2Component = NightBorne2();
    add(nightBorne2Component);

    this.wizardComponent = Wizard();
    wizardComponent.x = 1800;
    wizardComponent.renderFlipX = true;
    add(wizardComponent);

    this.changePriorities(
        {redHoodComponent: 10, nightBorne2Component: 9, wizardComponent: 11});

    this.visible = true;
    overlays.add(Hud.id);
    overlays.add(FadeAnimation.id);

    this.currentLevel = 8;
    this.loadedLevelEight = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentLevel', this.currentLevel);
  }

  void runLevelEightScript() {
    if (!diaSet9 && this.redHoodComponent.x > 0) {
      if (this.redHoodComponent.distance(this.nightBorne2Component) < 300) {
        this.diaSet9 = true;
        this.redHoodComponent.stopMoving();
        overlays.remove(Hud.id);
        overlays.add(DialoguesSet9.id);
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (this.visible) {
      super.render(canvas);
    }
  }
}
