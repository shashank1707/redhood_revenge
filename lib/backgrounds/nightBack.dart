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

class NightParallax extends ParallaxComponent with HasGameRef<RedHoodGame> {

  @override
  Future<void> onLoad() async {
    this.parallax = await gameRef.loadParallax([
      ParallaxImageData('parallax_night/SET1_bakcground_night1.png'),
      ParallaxImageData('parallax_night/SET1_bakcground_night2.png'),
      ParallaxImageData('parallax_night/SET1_bakcground_night3.png')
    ],
    velocityMultiplierDelta: Vector2(1.4, 0)
    );
  }
}