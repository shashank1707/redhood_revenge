import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class Hud extends StatelessWidget {
  static const id = 'Hud';

  final RedHoodGame gameRef;

  const Hud(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16),
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                    label: Text('')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'HP',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: gameRef.redHoodComponent.health,
                    builder: (__, double value, _) {
                      return Container(
                        width: width / 5,
                        child: LinearProgressIndicator(
                          value: value,
                          color: Colors.red,
                          backgroundColor: Colors.grey,
                        ),
                      );
                    })
              ],
            ),
            Opacity(
              opacity: 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_left_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        onPanDown: (details) {
                          gameRef.redHoodComponent.moveBackward();
                        },
                        onPanEnd: (details) {
                          gameRef.redHoodComponent.stopMoving();
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_right_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        onPanDown: (details) {
                          gameRef.redHoodComponent.moveForward();
                        },
                        onPanEnd: (details) {
                          gameRef.redHoodComponent.stopMoving();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: width / 10,
                          width: width / 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'assets/icon_images/sword.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPanDown: (details) {
                          gameRef.redHoodComponent.attack();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: width / 15,
                          width: width / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icon_images/arrow.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPanDown: (details) {
                          gameRef.redHoodComponent.jump();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
