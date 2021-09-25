import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:red_hood_revenge/mainMenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: FlameSplashScreen(
              onFinish: (context) => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MainMenu())),
              theme: FlameSplashTheme.dark)),
      theme: ThemeData(fontFamily: GoogleFonts.specialElite().fontFamily),
    );
  }
}
