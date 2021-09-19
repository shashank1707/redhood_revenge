import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/gameWidget.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ Key? key }) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.fromLTRB(150, 50, 150, 50),
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('REDHOOD REVENGE', style: TextStyle(
              fontSize: 45,
              color: Colors.white
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyGameWidget()));
              }, child: Text('Play', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30,),), style: ElevatedButton.styleFrom(
                              primary: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}