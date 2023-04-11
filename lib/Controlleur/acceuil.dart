import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:reseausocial/mes%20classes/membres.dart';

import '../Modele/Data.dart';
import '../Modele/Page.dart';
import '../custom_widget/BarItem.dart';

class Acceuil extends StatefulWidget{

  Acceuil({super.key});

  @override
  State<StatefulWidget> createState()=>_Acceuil();
}

class _Acceuil extends State<Acceuil>{

  List<Pages>lesPages = Data().lesPages();
  late Membres membres;
  int index = 0;

  @override
  Widget build(BuildContext context) {
     final donnee = lesPages.map((element) => element.destination).toList();
    return Scaffold(
            appBar: AppBar(
              title: Text("acceuil"),
            ),
            body:Container(
              width: double.infinity,
              height:  MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: donnee[index],
                  ),
                  Positioned(
                      bottom: 0,
                      child:Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRect(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                                child: Container(),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width*0.05),
                            width: MediaQuery.of(context).size.width*0.9,
                            height: MediaQuery.of(context).size.width*0.15,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BarItem(onPressed: () {setState(() {index = 0;});}, icon: Icon(Icons.house_rounded), valeur:(index == 0)),
                                BarItem(onPressed: () {setState(() {index = 1;});}, icon: Icon(Icons.person), valeur:(index == 1)),
                                BarItem(onPressed: () {setState(() {index = 2;});}, icon: Icon(Icons.notifications), valeur:(index == 2)),
                                BarItem(onPressed: () {setState(() {index = 3;});}, icon: Icon(Icons.border_color), valeur:(index == 3)),
                                BarItem(onPressed: () {setState(() {index = 4;});}, icon: Icon(Icons.group), valeur:(index == 4)),
                              ],
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          );
  }
}
