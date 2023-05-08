import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/BarDeNavigation.dart';

class AnimationIcons extends StatefulWidget{

  Widget child;
  int index;

  AnimationIcons({super.key,required this.child,required this.index});

  @override
  AnimationIconsState createState() => AnimationIconsState();
}

class AnimationIconsState extends State<AnimationIcons> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  Duration duration = Duration(milliseconds: 300);
  late Animation<Offset>animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: duration);
    curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);
    animation = Tween<Offset>(begin:Offset.zero,end: Offset(0,-0.3)).animate(curvedAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: IconButton(
        onPressed: (){
          changementEtat(widget.index);
          animationController.forward();
          animationController.addListener(() {
            if(animationController.isCompleted){
              animationController.reset();
            }
          });
        },
        icon:widget.child,
      )
    );
  }
  changementEtat(int valeur){
    setState(() {
      context.read<BarDeNavigation>().changeEtat(valeur);
    });
  }
}