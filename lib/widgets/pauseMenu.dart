
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/mainMenu.dart';
import 'package:red_hood_revenge/widgets/hud.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';

  final RedHoodGame gameRef;
  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.fromLTRB(150, 50, 150, 50),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Game Paused',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.resumeGame();
                    if(gameRef.currentLevel == 0){
                      gameRef.overlays.add(WarriorHud.id);
                    }else{
                      gameRef.overlays.add(Hud.id);
                    }
                    gameRef.overlays.remove(PauseMenu.id);
                  },
                  child: Text(
                    'Resume',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    gameRef.removeEverything();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainMenu()),
                        (route) => false);
                  },
                  child: Text(
                    'Main Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
