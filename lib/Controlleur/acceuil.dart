import 'package:flutter/material.dart';
import 'package:reseausocial/mes%20classes/membres.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'MainController.dart';

class Acceuil extends StatefulWidget{

  Acceuil({super.key});

  @override
  State<StatefulWidget> createState()=>_Acceuil();
}

class _Acceuil extends State<Acceuil>{

  String idUtilisateur = FirebaseAuth.instance.currentUser!.uid;
  late Membres membres;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("membres").doc(idUtilisateur).snapshots(),
        builder:(contexte,snapshot){
          if(snapshot.hasData){
            membres = Membres.fromJson(snapshot.data as DocumentSnapshot<Object?>);
            return MainController(membres: membres);
          }else{
            return Container(color: Colors.white);
          }
        }
    );
  }
}
