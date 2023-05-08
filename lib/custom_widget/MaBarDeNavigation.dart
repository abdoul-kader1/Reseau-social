import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/Posts.dart';
import '../Providers/BarDeNavigation.dart';
import '../firebase/gestionnaireFirebase.dart';
import 'AnimationIcons.dart';

class MaBarDeNavigation extends StatefulWidget{

  String idMembres;
  MaBarDeNavigation({super.key,required this.idMembres});
  @override
  MaBarDeNavigationState createState() => MaBarDeNavigationState();
}

class MaBarDeNavigationState extends State<MaBarDeNavigation>{
  int nombresNotification = 0;
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
         AnimationIcons(index:0,child: Icon(Icons.house_rounded,color: (context.watch<BarDeNavigation>().index == 0)?Colors.white:Colors.orange,size: 30)),
         AnimationIcons(index:1,child: Icon(Icons.person,color: (context.watch<BarDeNavigation>().index == 1)?Colors.white:Colors.orange,size: 30)),
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
         AnimationIcons(index:2,child: nouvelleNotification()),
         AnimationIcons(index:3,child: Icon(Icons.group,color: (context.watch<BarDeNavigation>().index == 3)?Colors.white:Colors.orange,size: 30)),
       ],
     ),
   );
  }
  //icon nouvelle notification
  nouvelleNotification(){
    GestionnaireFirbase().fireNotification.doc(widget.idMembres).collection("inside").where("seen",isEqualTo:false).snapshots().listen((event) {
     setState(() {
       nombresNotification = event.docs.length;
     });
    });
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(Icons.notifications,color: (context.watch<BarDeNavigation>().index == 2)?Colors.white:Colors.orange,size: 30,),
        (nombresNotification==0)?Container():Container(
          width: 16,
          height: 16,
          color: Colors.red,
          child: Center(child: Text("$nombresNotification",style: TextStyle(color: Colors.white))),
        )
      ],
    );
  }
}