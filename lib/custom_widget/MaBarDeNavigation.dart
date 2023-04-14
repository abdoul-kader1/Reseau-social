import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/Posts.dart';
import '../Providers/BarDeNavigation.dart';
import 'AnimationIcons.dart';

class MaBarDeNavigation extends StatefulWidget{

  String idMembres;
  MaBarDeNavigation({super.key,required this.idMembres});
  @override
  MaBarDeNavigationState createState() => MaBarDeNavigationState();
}

class MaBarDeNavigationState extends State<MaBarDeNavigation>{

  @override
  Widget build(BuildContext context) {
   return Container(
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
         AnimationIcons(index:0,child: Icon(Icons.house_rounded,color: (context.watch<BarDeNavigation>().index == 0)?Colors.white:Colors.orange)),
         AnimationIcons(index:1,child: Icon(Icons.person,color: (context.watch<BarDeNavigation>().index == 1)?Colors.white:Colors.orange)),
         FloatingActionButton(
           mini: true,
           onPressed: (){
             showModalBottomSheet(
                 context: context,
                 builder: (contexte){
                   return Posts(idMembre: widget.idMembres);
                 }
             );
           },
           backgroundColor: Colors.white,
           child: Icon(Icons.border_color,color: Colors.orange),
         ),
         AnimationIcons(index:2,child: Icon(Icons.notifications,color: (context.watch<BarDeNavigation>().index == 2)?Colors.white:Colors.orange)),
         AnimationIcons(index:3,child: Icon(Icons.group,color: (context.watch<BarDeNavigation>().index == 3)?Colors.white:Colors.orange)),
       ],
     ),
   );
  }
}