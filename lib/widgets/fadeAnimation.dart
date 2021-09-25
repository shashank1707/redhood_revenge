import 'package:flutter/material.dart';
import 'package:red_hood_revenge/game/redHoodGame.dart';

class FadeAnimation extends StatefulWidget {

  static const id = 'FadeAnimation';

  final RedHoodGame gameRef;

  const FadeAnimation(this.gameRef, { Key? key }) : super(key: key);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {

  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }



  void changeOpacity() async {

    await Future.delayed(Duration(seconds: 1)).then((value){
      setState(() {
        opacity = 0.0;
      });
    });
    
    await Future.delayed(Duration(seconds: 2)).then((value){
      widget.gameRef.overlays.remove(FadeAnimation.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(opacity: opacity, duration: Duration(seconds: 2), child: Container(color: Colors.black,)
    );
    // return Container();
  }
}

class FadeAnimationReverse extends StatefulWidget {

  static const id = 'FadeAnimationReverse';

  final RedHoodGame gameRef;

  const FadeAnimationReverse(this.gameRef, { Key? key }) : super(key: key);

  @override
  _FadeAnimationReverseState createState() => _FadeAnimationReverseState();
}

class _FadeAnimationReverseState extends State<FadeAnimationReverse> {

  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  void changeOpacity() async {
    await Future.delayed(Duration(seconds: 1)).then((value){
      setState(() {
        opacity = 1.0;
      });
    });
    await Future.delayed(Duration(seconds: 3)).then((value){
      widget.gameRef.overlays.remove(FadeAnimationReverse.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimatedOpacity(opacity: opacity, duration: Duration(seconds: 2), child: Container(color: Colors.black,)
    );
    // return Container();
  }
}