import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class DayParallax extends ParallaxComponent with HasGameRef<RedHoodGame> {

  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax([
      ParallaxImageData('parallax_day/SET1_bakcground_day1.png'),
      ParallaxImageData('parallax_day/SET1_bakcground_day2.png'),
      ParallaxImageData('parallax_day/SET1_bakcground_day3.png'),
    ]);
  }
}