import 'package:flutter/material.dart';

class BarItem extends IconButton{

  BarItem({required super.onPressed, required super.icon,required bool valeur}):super(
    color: valeur?Colors.white:Colors.orange
  );

}