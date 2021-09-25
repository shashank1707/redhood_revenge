import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_hood_revenge/about.dart';
import 'package:red_hood_revenge/gameWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ Key? key }) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('REDHOOD REVENGE', style: TextStyle(
                  fontSize: 45,
                  color: Colors.white
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => SelectSavedGame()));
                }, child: Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                                primary: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                }, child: Text('About', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                                primary: Colors.white),),
              )
            ],
          ),
      ),
    );
  }
}


class SelectSavedGame extends StatefulWidget {
  const SelectSavedGame({ Key? key }) : super(key: key);

  @override
  _SelectSavedGameState createState() => _SelectSavedGameState();
}

class _SelectSavedGameState extends State<SelectSavedGame> {


  int currentLevel = 0;

  @override
  void initState() {
    super.initState();
    findSavedGame();
  }

  void findSavedGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int level = prefs.getInt('currentLevel') ?? 0;
    setState(() {
      currentLevel = level;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('PLAY', style: TextStyle(
                  fontSize: 45,
                  color: Colors.white
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyGameWidget(currentLevel)));
                }, child: Text('Load Game', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                                primary: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyGameWidget(0)));
                }, child: Text('New Game', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                                primary: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Back', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                                primary: Colors.white),),
              )
            ],
          ),
      ),
    );
  }
}