import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';
import 'package:red_hood_revenge/widgets/fadeAnimation.dart';

class DialoguesSet3 extends StatefulWidget {
  static const id = 'DialogueSet3';

  final RedHoodGame gameRef;

  const DialoguesSet3(this.gameRef, {Key? key}) : super(key: key);

  @override
  _DialoguesSet3State createState() => _DialoguesSet3State();
}

class _DialoguesSet3State extends State<DialoguesSet3> {
  String dialogue = "";
  String image = "";
  String character = "";
  int index = 0;

  Map<String, String> images = {
    "Redhood": "assets/images/Characters/redhood.png",
    "NightBorne": "assets/images/Characters/main.png",
    "Wizard": "assets/images/Characters/wizard.png",
    "Warrior": "assets/images/Characters/warror.png",
  };

  List<Map<String, String>> dialogueList = [
    {"character": "Redhood", "dialogue": "FATHER !!!"},
    {"character": "Redhood", "dialogue": "Who did this to you?"},
    {"character": "Wizard", "dialogue": "It was NightBorne."},
    {"character": "Wizard", "dialogue": "Your father didn't know that NightBorne has already acquired the immortality potion."},
    {"character": "Redhood", "dialogue": "Where is he? I've got to find him, I've got to avenge my father."},
    {"character": "Wizard", "dialogue": "NightBorne is no weakling. And now that he has the immortality potion, there's nothing you can do to defeat him."},
    {"character": "Redhood", "dialogue": "But I've got to do what needs to be done. Teach me. Teach me how to defeat him."},
    {"character": "Wizard", "dialogue": "Meet me in the morning near the old broken tree trunk."},
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      image = images[dialogueList[index]["character"]]!;
      dialogue = dialogueList[index]["dialogue"]!;
      character = dialogueList[index]["character"]!;
    });
  }

  void changeDialogue() async {
    if (index + 1 < dialogueList.length) {
      setState(() {
        image = images[dialogueList[index + 1]["character"]]!;
        dialogue = dialogueList[index + 1]["dialogue"]!;
        character = dialogueList[index + 1]["character"]!;
        index++;
      });
    }else{
      widget.gameRef.overlays.remove(DialoguesSet3.id);
      widget.gameRef.overlays.add(FadeAnimationReverse.id);
      await Future.delayed(Duration(seconds: 2)).then((value){
        widget.gameRef.removeEverything();
        widget.gameRef.loadLevelOne();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(16.0),
            width: width,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  image,
                                  height: 35,
                                  width: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    character,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              dialogue,
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        changeDialogue();
                      },
                      child: Text(
                        'next',
                        style: TextStyle(color: Colors.purple),
                      )),
                ]),
          )
        ],
      ),
    );
  }
}
