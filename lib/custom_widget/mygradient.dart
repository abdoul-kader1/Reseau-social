import 'package:flutter/material.dart';

class Mygradient extends BoxDecoration{

  Mygradient({
    required Color startcolors,
    required Color endcolors,
    bool horizontal :false,
    double radius:0
  }):super(
    gradient: LinearGradient(
        colors:[startcolors,endcolors],
        begin:FractionalOffset(0,0),
        end: horizontal?FractionalOffset(1,0):FractionalOffset(0,1)
    ),
    borderRadius: BorderRadius.circular(radius)
  );
}