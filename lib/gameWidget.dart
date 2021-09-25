
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet1.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet10.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet2.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet3.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet4.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet5.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet6.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet7.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet8.dart';
import 'package:red_hood_revenge/widgets/dialogues/diaSet9.dart';
import 'package:red_hood_revenge/widgets/fadeAnimation.dart';
import 'package:red_hood_revenge/widgets/finalSccreen.dart';
import 'package:red_hood_revenge/widgets/hud.dart';
import 'package:red_hood_revenge/widgets/pauseMenu.dart';
import 'package:red_hood_revenge/widgets/retryMenu.dart';

class MyGameWidget extends StatefulWidget {

  final currentLevel;

  const MyGameWidget(this.currentLevel, {Key? key}) : super(key: key);

  @override
  _MyGameWidgetState createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: RedHoodGame(widget.currentLevel),
      overlayBuilderMap: {
        FadeAnimation.id: (_, RedHoodGame gameRef) => FadeAnimation(gameRef),
        FadeAnimationReverse.id: (_, RedHoodGame gameRef) => FadeAnimationReverse(gameRef),
        PauseMenu.id: (_, RedHoodGame gameRef) => PauseMenu(gameRef),
        RetryMenu.id: (_, RedHoodGame gameRef) => RetryMenu(gameRef),
        Hud.id: (_, RedHoodGame gameRef) => Hud(gameRef),
        WarriorHud.id: (_, RedHoodGame gameRef) => WarriorHud(gameRef),
        DialoguesSet1.id: (_, RedHoodGame gameRef) => DialoguesSet1(gameRef),
        DialoguesSet2.id: (_, RedHoodGame gameRef) => DialoguesSet2(gameRef),
        DialoguesSet3.id: (_, RedHoodGame gameRef) => DialoguesSet3(gameRef),
        DialoguesSet4.id: (_, RedHoodGame gameRef) => DialoguesSet4(gameRef),
        DialoguesSet5.id: (_, RedHoodGame gameRef) => DialoguesSet5(gameRef),
        DialoguesSet6.id: (_, RedHoodGame gameRef) => DialoguesSet6(gameRef),
        DialoguesSet7.id: (_, RedHoodGame gameRef) => DialoguesSet7(gameRef),
        DialoguesSet8.id: (_, RedHoodGame gameRef) => DialoguesSet8(gameRef),
        DialoguesSet9.id: (_, RedHoodGame gameRef) => DialoguesSet9(gameRef),
        DialoguesSet10.id: (_, RedHoodGame gameRef) => DialoguesSet10(gameRef),
        FinalScreen.id: (_, RedHoodGame gameRef) => FinalScreen(gameRef),
      },
    );
  }
}
