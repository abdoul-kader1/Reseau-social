import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseausocial/mes%20classes/membres.dart';
import '../Pages/Groupes.dart';
import '../Pages/Menu.dart';
import '../Pages/Notifications.dart';
import '../Pages/Profil.dart';
import '../Providers/BarDeNavigation.dart';
import '../custom_widget/MaBarDeNavigation.dart';

class MainController extends StatefulWidget {

  Membres membres;

  MainController({super.key,required this.membres});

  @override
  MainControllerState createState() =>MainControllerState();

}

class MainControllerState extends State<MainController>{

  int index = 0;
  @override
  Widget build(BuildContext context) {
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
           donnee(),
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
                   MaBarDeNavigation(idMembres: widget.membres.uid!,)
                 ],
               )
           )
         ],
       ),
     ),
   );
  }
  donnee(){
    if(context.watch<BarDeNavigation>().index == 0){
      return Menu(membres:widget.membres);
    }else if(context.watch<BarDeNavigation>().index == 1){
      return Profil(membres:widget.membres);
    }else if(context.watch<BarDeNavigation>().index == 2){
      return Notifications(membres:widget.membres);
    }else if(context.watch<BarDeNavigation>().index == 3){
      return Groupes(membres:widget.membres);
    }
  }
}