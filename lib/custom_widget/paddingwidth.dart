import 'package:flutter/material.dart';

class PaddingWidth extends Padding{
  PaddingWidth({
    required Widget child,
    double top:20.0,
    double bottom:20.0,
    double left:20.0,
    double right:20.0,
}):super(
    padding:EdgeInsets.only(top: top,left: left,right: right,bottom: bottom),
    child: child
  );

}