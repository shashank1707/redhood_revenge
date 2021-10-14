import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class DialoguesSet8 extends StatefulWidget {
  static const id = 'DialogueSet8';

  final RedHoodGame gameRef;

  const DialoguesSet8(this.gameRef, {Key? key}) : super(key: key);

  @override
  _DialoguesSet8State createState() => _DialoguesSet8State();
}

class _DialoguesSet8State extends State<DialoguesSet8> {
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
    {"character": "Redhood", "dialogue": "(Grunts) AHH!! What's happening? I can't move."},
    {"character": "NightBorne", "dialogue": "HAHA!... You still don't know anything about the potions. No potion is perfect. This is the side effects of the potion you just took. Each and every one of your organs is frozen in its place, except for your head, of course."},
    {"character": "NightBorne", "dialogue": "You're not a bad fighter for a girl, kid. But now that I'm about to end your life, tell me - why did you come here tonight?"},
    {"character": "Redhood", "dialogue": "I'm your worst nightmare."},
    {"character": "NightBorne", "dialogue": "Too Bad! I don't have nightmares. I create them."},
    {"character": "Redhood", "dialogue": "You killed him. You killed my father. You hideous, wicked creature."},
    {"character": "NightBorne", "dialogue": "HAHAHA...!! You're so naive. That wizard friend of yours?"},
    {"character": "NightBorne", "dialogue": "He is the one who ordered me to kill your father."},
    {"character": "NightBorne", "dialogue": "HE IS the reason I'm so powerful today."},
    {"character": "Redhood", "dialogue": "WHAT? But I- The potions-"},
    {"character": "NightBorne", "dialogue": "Ahh Yes, the potions. Thanks to you, he will now rule this planet."},
    {"character": "NightBorne", "dialogue": "He will combine those potions to create an Ultimate Potion. The potion will give him the power to get control over everyone's mind and soul."},
    {"character": "NightBorne", "dialogue": "This power is detrimental, it messes up your brain - You forget who you are, you forget where you belong, you forget why you exist."},
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

  Future<void> changeDialogue() async {
    if (index + 1 < dialogueList.length) {
      setState(() {
        image = images[dialogueList[index + 1]["character"]]!;
        dialogue = dialogueList[index + 1]["dialogue"]!;
        character = dialogueList[index + 1]["character"]!;
        index++;
      });
    }else{
      widget.gameRef.overlays.remove(DialoguesSet8.id);
      widget.gameRef.wizardComponent.moveBackward();
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
