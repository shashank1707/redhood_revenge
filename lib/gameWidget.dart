import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/widgets/hud.dart';

class MyGameWidget extends StatefulWidget {
  const MyGameWidget({Key? key}) : super(key: key);

  @override
  _MyGameWidgetState createState() => _MyGameWidgetState();
}

class _MyGameWidgetState extends State<MyGameWidget> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: RedHoodGame(),
      overlayBuilderMap: {
        Hud.id: (_, RedHoodGame gameRef) => Hud(gameRef),
      },
      initialActiveOverlays: [Hud.id],
    );
  }
}
