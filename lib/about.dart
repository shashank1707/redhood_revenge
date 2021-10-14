import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 25,), label: Text("")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Redhood Revenge', style: TextStyle(fontSize: 40, color: Colors.white),),
                  ),
                  SizedBox()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('Redhood Revenge is a 2D Platformer mobile game created with Flame Engine on top of Flutter. It is an action type game which consist of multiple levels built around a story.', style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Developer: Kumar Shashank', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}