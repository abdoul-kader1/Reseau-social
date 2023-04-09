// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:math';

import 'package:flutter/material.dart';

class Mypainter extends CustomPainter{

  late Paint painter;
  late PageController pageController;

   Mypainter({required this.pageController}):super(
     repaint: pageController
   ){
     painter=Paint()
        ..color=Colors.white
        ..style=PaintingStyle.fill;
   }

  @override
  void paint(Canvas canvas, Size size) {
     if(pageController!=null && pageController.position!=null){
       final radius=20.0;
       final dy=25.0;
       final dxcurrent=25.0;
       final dxtarget=125.0;
       final position=pageController.position;
       final extent=(position.maxScrollExtent-position.minScrollExtent+position.viewportDimension);
       final offset =position.extentBefore/extent;
       bool toright= dxcurrent<dxtarget;
       Offset entry= Offset(toright?dxcurrent:dxtarget, dy);
       Offset target=Offset(toright?dxtarget:dxcurrent, dy);
       Path path=Path();
       path.addArc(Rect.fromCircle(center: entry, radius: radius), 0.5* pi, 1*pi);
       path.addRect(Rect.fromLTRB(entry.dx,dy-radius,target.dx, dy+radius));
       path.addArc(Rect.fromCircle(center:target, radius: radius),1.5*pi,1*pi);
       canvas.translate(size.width*offset,0);
       canvas.drawShadow(path, Colors.grey,7.5,true);
       canvas.drawPath(path, painter);
     }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;

}
