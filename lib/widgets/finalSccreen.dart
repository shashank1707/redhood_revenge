import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/mainMenu.dart';

class FinalScreen extends StatefulWidget {
  static const id = 'FinalScreen';

  final RedHoodGame gameRef;

  const FinalScreen(this.gameRef, {Key? key}) : super(key: key);

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  void changeOpacity() async {
    await Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: 2),
          child: Container(
            height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'To Be Continued ...',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Thank you for playing',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    widget.gameRef.removeEverything();
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
          )),
    );
    // return Container();
  }
}
