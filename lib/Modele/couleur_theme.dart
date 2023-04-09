import 'package:flutter/material.dart';

class Colorstheme{
  //sans contexte
  bool isdark(){
    final windows=WidgetsBinding.instance.window;
    final mode=MediaQueryData.fromWindow(windows).platformBrightness;
    return(mode==Brightness.dark);
  }
  //avec contexte
  bool isdarkWithContext(BuildContext context){
    final mode=MediaQuery.of(context).platformBrightness;
    return(mode==Brightness.dark);
  }
  //Les couleurs
  Color Primary()=>isdark()?Color.fromRGBO(238, 130,238,0.58):Colors.purple.shade400;
  Color Base()=>isdark()?Colors.black:Colors.white;
  Color Accent()=>isdark()?Colors.grey:Colors.black38;
}